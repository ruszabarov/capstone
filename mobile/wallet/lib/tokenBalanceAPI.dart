import 'dart:convert';
import 'private.dart';
import 'package:etherscan_api/etherscan_api.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';

final etherscan = EtherscanAPI(apiKey: apiKey, chain: EthChain.rinkeby);
final myAddress = "0x127Ff1D9560F7992911389BA181f695b38EE9399";


void getTokenList() async{
  final String abi = await rootBundle.loadString("assets/build/contracts/token-list-rinkeby.json");
  final json = await jsonDecode(
    abi,
  );
  String getAddresses(int i) {
    return json[i]["address"] as String;
  }
  for(int i = 0; i < json.length; i++) {
    final balance = await etherscan.tokenBalance(address: myAddress, contractAddress: getAddresses(i));

    await Future.delayed(Duration(seconds: 1));
    print(balance);
  }
  
}

void addToken(String name, String symbol, String address, int decimal) async {
  final String abi = await rootBundle.loadString("assets/build/contracts/token-list-rinkeby.json");
  int length = abi.length;
  
}