import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:web3dart/web3dart.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:wallet/private.dart';
import 'package:wallet/screens/authentication/login.dart';
import 'package:wallet/screens/wrapper.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:wallet/test.dart';
import 'package:web3dart/web3dart.dart';

bool data = false;
int myAmount = 3;
final myAddress = "0x127Ff1D9560F7992911389BA181f695b38EE9399";
EthereumAddress myAddress1 = EthereumAddress.fromHex(myAddress);
String DAIcontract = "0x6a9865ade2b6207daac49f8bcba9705deb0b0e6d"; 

var myData;
Client httpClient = new Client();
Web3Client ethClient = new Web3Client(
    "https://rinkeby.infura.io/v3/f58b56df688c4bafba806114fb329aaa",
    httpClient);



Future<String> getEthBalance(EthereumAddress from) async {
  const decimals = 18;
  dynamic balance = await ethClient.getBalance(from).then((value) => value.getInWei);
  return (balance.toDouble() / pow(10, decimals)).toStringAsFixed(4);
}

Future<DeployedContract> loadContract(String from) async {
  String abi = await rootBundle.loadString("assets/build/contracts/abi-erc20.json");
  final EthereumAddress contractAddress = await EthereumAddress.fromHex(await loadTokenContract(from));
  final contract = DeployedContract(ContractAbi.fromJson(abi, from), contractAddress);

  return contract;
}

Future<String> loadTokenContract(String tokenName) async {
  final String abi = await rootBundle.loadString("assets/build/contracts/token-list-rinkeby.json");
  final json = await jsonDecode(abi, );
  for(int i = 0; i < json.length; i++) {
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
     params: [from]).then((value) => EtherAmount.fromUnitAndValue(EtherUnit.wei, value[0]).getInWei);

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
/*
Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
  final contract = await loadContract();
  final ethFunction = contract.function(functionName);
  final result = await ethClient.call(
      contract: contract, function: ethFunction, params: args);

  return result;
}


  Future<dynamic> getBalance(String targetAddress) async {
    // EthereumAddress address = EthereumAddress.fromHex(targetAddress);
    List<dynamic> result = await query("getBalance", []);

    myData = result[0];
    data = true;
    
    double newBalance = myData.toDouble();
    newBalance = newBalance / 1000000000000000000;
    return newBalance.toString();
  }

Future<String> withdrawCoin() async {
  var bigAmount = BigInt.from(myAmount);
  var response = await submit("withdrawBalance", [bigAmount]);
  return response;
}

Future<String> depositCoin() async {
  var bigAmount = BigInt.from(myAmount);
  var response = await submit("depositBalance", [bigAmount]);
  return response;
}

Future<String> submit(String funtionName, List<dynamic> args) async {
  EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract();
  final ethFunction = contract.function(funtionName);
  final result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
          contract: contract,
          function: ethFunction,
          parameters: args,
          maxGas: 100000000),
      chainId: 4);

  return result;
  
}
*/
