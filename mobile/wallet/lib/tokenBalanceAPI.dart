import 'dart:convert';

import 'package:etherscan_api/etherscan_api.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';

final eth = EtherscanAPI(apiKey: 'ZCY26NRJI1EZ1U7BSKYTKIIYWAGH86ADFT', chain: EthChain.rinkeby);
final myAddress = "0x039749DdBf1CCbFe20548fA9fF4521eecC4a0a02";


void getTokenList() async{
  final String abi = await rootBundle.loadString("assets/build/contracts/token-list-rinkeby.json");
  final json = await jsonDecode(
    abi,
  );
  String getAddresses(i) {
    return json[i]["address"] as String;
  }
  for(int i = 0; i < json.length(); i++) {
    print(await eth.tokenBalance(address: myAddress, contractAddress: getAddresses(i)));
  }
}