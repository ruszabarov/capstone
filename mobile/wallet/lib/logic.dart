import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:wallet/private.dart';

final myAddress = "0x039749DdBf1CCbFe20548fA9fF4521eecC4a0a02";
EthereumAddress myAddress1 = EthereumAddress.fromHex(myAddress);

Client httpClient = new Client();
Web3Client ethClient = new Web3Client(
    "https://rinkeby.infura.io/v3/f58b56df688c4bafba806114fb329aaa",
    httpClient);


Future<String> getEthBalance(EthereumAddress from) async {
  const decimals = 18;
  dynamic balance =
      await ethClient.getBalance(from).then((value) => value.getInWei);
  return (balance.toDouble() / pow(10, decimals)).toStringAsFixed(4);
}

Future<DeployedContract> loadContract(String from) async {
  String abi =
      await rootBundle.loadString("assets/build/contracts/abi-erc20.json");
  final EthereumAddress contractAddress =
      await EthereumAddress.fromHex(await loadTokenContract(from));
  final contract =
      DeployedContract(ContractAbi.fromJson(abi, from), contractAddress);

  return contract;
}

Future<String> loadTokenContract(String tokenName) async {
  final String abi = await rootBundle
      .loadString("assets/build/contracts/token-list-rinkeby.json");
  final json = await jsonDecode(
    abi,
  );
  for (int i = 0; i < json.length; i++) {
    if (json[i]["name"] == tokenName) {
      return json[i]["address"] as String;
    }
  }
  return "Null";
}

Future<String> getTokenBalance(EthereumAddress from, String tokenName) async {
  final decimals = 18;
  final contract = await loadContract(tokenName);
  final balance = await ethClient.call(
      contract: contract,
      function: contract.function("balanceOf"),
      params: [
        from
      ]).then((value) =>
      EtherAmount.fromUnitAndValue(EtherUnit.wei, value[0]).getInWei);
  return (balance.toDouble() / pow(10, decimals)).toStringAsFixed(3);
}

void sendERC20(String targetAddress, String tokenName, int value) async {
  var credentials = EthPrivateKey.fromHex(privateKey);
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
  var multisendAddress = "0x649917Fb21e2aF4F4087CCcB58D349a2999E3Cc5";
  var credentials = EthPrivateKey.fromHex(privateKey);
  String abi = await rootBundle.loadString("assets/build/contracts/multisend-abi.json");
  final contract =  DeployedContract(ContractAbi.fromJson(abi, "Multisend"), EthereumAddress.fromHex(multisendAddress));
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

void sendEth(String targetAddress, int value) async {
  var credentials = EthPrivateKey.fromHex(privateKey);

  await ethClient.sendTransaction(
    credentials,
    Transaction(
      to: EthereumAddress.fromHex(targetAddress),
      // gasPrice: EtherAmount.inWei(BigInt.one),
      maxGas: 10000000,
      value: EtherAmount.fromUnitAndValue(EtherUnit.finney, value),
    ),
    chainId: 4,
  );
}
