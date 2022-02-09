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

// class Token {
//   String name; 
//   String symbol; 
//   String address; 
//   int decimal;
//   // Token(String name, String symbol, String address, int decimal){
//   //   this.name = name;

//   // }
// }


abstract class ITokenService {
  void addToken(String name, String symbol, String address, int decimal);
  Map<String, dynamic>? getTokens();
}

class TokenService implements ITokenService {
  const TokenService(this._preferences);

  final SharedPreferences _preferences;

  @override
  void addToken(String name, String symbol, String address, int decimals) async {
  // use shared_preferences to store user preferences
  Map<String, dynamic> token = {'name':name,'address':address,'symbol':symbol,'decimals':decimals};
  // final decode_options = jsonDecode(await rootBundle.loadString("assets/build/contracts/token-list-rinkeby.json"));
  await _preferences.setString('token', jsonEncode(token));
}
  // gets
  @override
  Map<String, dynamic>? getTokens() {
    String? userTokens = _preferences.getString('token');
    if(userTokens == null) {
      return null;
    } else {
      return jsonDecode(userTokens) as Map<String, dynamic>;
    }
  }
}