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

final etherscan = EtherscanAPI(apiKey: apiKey, chain: EthChain.rinkeby, enableLogs: false);
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

class Token {
  String name = "";
  String symbol = "";
  String address = "";
  int decimal = 0;
  Token(
      {required this.name,
      required this.symbol,
      required this.address,
      required this.decimal});

  factory Token.fromJson(Map<dynamic, dynamic> parsedJson) {
    return new Token(
        name: parsedJson['name'] ?? "",
        symbol: parsedJson['symbol'] ?? "",
        address: parsedJson['address'] ?? "",
        decimal: parsedJson['decimal'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "symbol": this.symbol,
      "address": this.address,
      "decimal": this.decimal,
    };
  }
}

abstract class ITokenService {
  void addToken(String name, String symbol, String address, int decimal);
  Map<String, dynamic>? getTokens();
}

class TokenService implements ITokenService {
  const TokenService(this._preferences);

  final SharedPreferences _preferences;

  @override
  void addToken(
      String name, String symbol, String address, int decimals) async {
      
  }

  // gets
  @override
  Map<String, dynamic>? getTokens() {
    String? userTokens = _preferences.getString('token');
    if (userTokens == null) {
      return null;
    }
    return jsonDecode(userTokens) as Map<String, dynamic>;
  }
}


Future<void> setPath() async {
    bool fileExists = false;
    String fileName = "tokensJSON.json";
    Map<String, dynamic> fileContent;
    Directory dir = await getApplicationDocumentsDirectory();
    File jsonFile = new File(dir.path + "/" + fileName);
    fileExists = await jsonFile.exists();
    if(fileExists) {
      fileContent = jsonDecode(jsonFile.readAsStringSync());
    }

    void createFile(Map<String, dynamic> content, Directory dir, String fileName) {
      print("Creating file");
      File file =  new File(dir.path + "/" + fileName);
      file.createSync();
      fileExists = true;
      file.writeAsStringSync(jsonEncode(content));
    }

    void writeToFile(String key, dynamic value) {
      print("Writing to file");
      Map<String, dynamic> content = {key: value};
      if(fileExists){
        print("File exists");
        Map<String, dynamic> jsonFileContent = jsonDecode(jsonFile.readAsStringSync());
        jsonFileContent.addAll(content);
        jsonFile.writeAsStringSync(jsonEncode(jsonFileContent));
      } else {
        print("File does not exist");
        createFile(content, dir, fileName);
      }
    }

}


class FileManager {

}
