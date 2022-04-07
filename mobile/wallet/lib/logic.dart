import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:wallet/configuration_service.dart';
import 'package:wallet/network_service.dart';
import 'package:wallet/tokenBalanceAPI.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:wallet/private.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tokenBalanceAPI.dart';

// TODO: Gas, receipts, functions adjusted for accounts.

final myAddress = "0x127Ff1D9560F7992911389BA181f695b38EE9399";
EthereumAddress myAddress1 = EthereumAddress.fromHex(myAddress);

Client httpClient = new Client();
Web3Client ethClient = new Web3Client(
    "https://eth-rinkeby.gateway.pokt.network/v1/lb/6212b3749c8d48003a41d3b2",
    httpClient);

Future<String> getEthBalance(String from) async {
  const decimals = 18;
  dynamic balance = await ethClient
      .getBalance(EthereumAddress.fromHex(from))
      .then((value) => value.getInWei);
  return (balance.toDouble() / pow(10, decimals)).toStringAsFixed(4);
}

Future<DeployedContract> loadContract(String from) async {
  String abi =
      await rootBundle.loadString("assets/build/contracts/abi-erc20.json");
  final Token token = await loadTokenContract(from);
  final EthereumAddress contractAddress =
      await EthereumAddress.fromHex(token.address);
  final contract =
      DeployedContract(ContractAbi.fromJson(abi, from), contractAddress);

  return contract;
}

Future<dynamic> getReceipt(String txHash) async {
  var receipt = await ethClient.getTransactionReceipt(txHash);
  if (receipt == null) {
    return "Transaction is null";
  }

  return receipt;
}

Future<Token> loadTokenContract(String tokenName) async {
  ConfigurationService configurationService =
      new ConfigurationService(await SharedPreferences.getInstance());

  NetworkService networkService =
      new NetworkService(await SharedPreferences.getInstance());

  // await networkService.addMainnet();
  await networkService.addNetwork(
      "ropsten",
      "https://eth-ropsten.gateway.pokt.network/v1/lb/6212b3749c8d48003a41d3b2",
      3);
  List<Network> networkList = await networkService.getNetworkList();
  print(networkList[1].name);
  List<Gas> gaz = await estimateGas();
  print(gaz[0].price);
  // TransactionReceipt receipt =
  print(await getTransactionReceipt(
      "0xa1eec124ff34d65dc38ec27ea6d5575e049ad5d787fb04c3c7abb54dc8d584a1"));
  print(await ethTxHistory(myAddress));

  await configurationService.addEther(1);
  await configurationService.addToken(1, "ChainLink Token", "LINK",
      "0x01BE23585060835E02B77ef475b0Cc51aA1e0709", 18);

  final json = await configurationService.getTokens();
  for (int i = 0; i < json.length; i++) {
    if (json[i].name == tokenName) {
      return json[i];
    }
  }
  return json.first;
}

Future<String> getTokenBalance(int id, String tokenName) async {
  ConfigurationService configurationService =
      new ConfigurationService(await SharedPreferences.getInstance());

  await configurationService.firstAccount("1");
  await configurationService.importAccount(privateKey, "2");
  Account from = await configurationService.getAccount(id);

  Client httpClient = new Client();
  Web3Client ethClient = new Web3Client(
      "https://eth-rinkeby.gateway.pokt.network/v1/lb/6212b3749c8d48003a41d3b2",
      httpClient);

  final decimals = 18;
  final contract = await loadContract(tokenName);
  final balance = await ethClient.call(
      contract: contract,
      function: contract.function("balanceOf"),
      params: [
        EthereumAddress.fromHex(from.publicKey)
      ]).then((value) =>
      EtherAmount.fromUnitAndValue(EtherUnit.wei, value[0]).getInWei);
  return (balance.toDouble() / pow(10, decimals)).toStringAsFixed(4);
}

void sendERC20(
    String targetAddress, String tokenName, int value, int id) async {
  ConfigurationService configurationService =
      new ConfigurationService(await SharedPreferences.getInstance());
  var credentials = EthPrivateKey.fromHex(
      await configurationService.getAccountPrivateKey(id));
  final contract = await loadContract(tokenName);
  List<dynamic> args = [myAddress1, targetAddress, value];

  await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
          contract: contract,
          function: contract.function("transferFrom"),
          parameters: args,
          maxGas: 100000000),
      chainId: 4);
}

void multisendETH(List<String> targetAddresses, List<int> values) async {
  var multisendAddress = "0x4E23B5327664C945d74bD17606724efdf960E154";
  var credentials = EthPrivateKey.fromHex(privateKey);
  String abi =
      await rootBundle.loadString("assets/build/contracts/multisend-abi.json");
  final contract = DeployedContract(ContractAbi.fromJson(abi, "Multisend"),
      EthereumAddress.fromHex(multisendAddress));
  List<dynamic> args = [targetAddresses, values];

  await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
          contract: contract,
          function: contract.function("withdrawls"),
          parameters: args,
          maxGas: 100000000),
      chainId: 4);
}

void sendEth(String targetAddress, int value, int id) async {
  ConfigurationService configurationService =
      new ConfigurationService(await SharedPreferences.getInstance());
  var credentials = EthPrivateKey.fromHex(
      await configurationService.getAccountPrivateKey(id));

  var txHash = await ethClient.sendTransaction(
    credentials,
    Transaction(
      to: EthereumAddress.fromHex(targetAddress),
      // gasPrice: EtherAmount.inWei(BigInt.one),
      maxGas: 10000000,
      value: EtherAmount.fromUnitAndValue(EtherUnit.finney, value),
    ),
    chainId: 4,
  );

  await Future.delayed(Duration(seconds: 30));
  var receipt = await ethClient.getTransactionReceipt(txHash);
  print("receipt: " + receipt.toString());
}
