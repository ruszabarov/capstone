import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:wallet/private.dart';

final myAddress = "0x127Ff1D9560F7992911389BA181f695b38EE9399";
EthereumAddress myAddress1 = EthereumAddress.fromHex(myAddress);

Client httpClient = new Client();
Web3Client ethClient = new Web3Client(
    "https://rinkeby.infura.io/v3/f58b56df688c4bafba806114fb329aaa",
    httpClient);

dynamic createWallet(String pass) {
  Wallet wallet =
      new Wallet.createNew(createPrivateKey(), pass, Random.secure());
  return wallet.toJson();
}

dynamic createPrivateKey() {
  return EthPrivateKey.createRandom(Random.secure());
}

String getAddressFromPK(EthPrivateKey add) {
  return add.address.toString();
}

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

Future<String> getTokenBalance(String from, String tokenName) async {
  Client httpClient = new Client();
  Web3Client ethClient = new Web3Client(
      "https://rinkeby.infura.io/v3/f58b56df688c4bafba806114fb329aaa",
      httpClient);

  final decimals = 18;
  final contract = await loadContract(tokenName);
  final balance = await ethClient.call(
      contract: contract,
      function: contract.function("balanceOf"),
      params: [
        EthereumAddress.fromHex(from)
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
