import 'dart:convert';
import 'package:wallet/providers/Token.dart';
import 'private.dart';
import 'package:etherscan_api/etherscan_api.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final etherscan =
    EtherscanAPI(apiKey: apiKey, chain: EthChain.rinkeby, enableLogs: false);
final myAddress = "0x127Ff1D9560F7992911389BA181f695b38EE9399";

void getTokenList() async {
  final String abi = await rootBundle
      .loadString("assets/build/contracts/token-list-rinkeby.json");
  final json = await jsonDecode(
    abi,
  );

  List<dynamic> tokenList = [];

  String getAddresses(int i) {
    return json[i]["address"];
  }

  for (int i = 0; i < json.length; i++) {
    final balance = await etherscan.tokenBalance(
        address: myAddress, contractAddress: getAddresses(i));

    await Future.delayed(Duration(seconds: 1));
    tokenList.add(balance.result);
  }

  print(tokenList);
}

