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

class TokenManager {
  bool fileExists = false;
  String fileName = "tokensJSON.json";
  Map<String, dynamic> fileContent = {};

  Future<Directory> get _localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir;
  }

  Future<File> get _jsonFile async {
    Directory localPath = await _localPath;
    return File(localPath.path + "/" + fileName);
  }

  Future<void> get _fileExists async {
    File jsonFile = await _jsonFile;
    fileExists = await jsonFile.existsSync();
    if (fileExists) {
      fileContent = jsonDecode(jsonFile.readAsStringSync());
    }
  }

  void createFile(
      Map<String, dynamic> content, Directory dir, String fileName) {
    print("Creating file");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(jsonEncode(content));
  }

  void writeToFile(
      String name, String address, String symbol, int decimals) async {
    print("Writing to file");
    String valSetOne = symbol + "," + address + "," + decimals.toString();
    Map<String, dynamic> content = {name: valSetOne};
    Directory dir = await _localPath;
    File jsonFile = await _jsonFile;
    await _fileExists;
    if (fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent =
          jsonDecode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(jsonEncode(jsonFileContent));
    } else {
      print("File does not exist");
      createFile(content, dir, fileName);
    }
  }

  dynamic readFile() async {
    await _fileExists;

    if (fileExists == false) {
      return "File doesn't exist";
    }

    File jsonFile = await _jsonFile;
    fileContent = jsonDecode(await jsonFile.readAsStringSync());
    return fileContent;
  }

  Future<String?> getTokenContractByName(String tokenName) async {
    String contract = '';
    try {
      final file = await readFile();
      await file.forEach((key, value) {
        if (key == tokenName) {
          List args = value.split(',');
          contract = args[1];
        }
      });
    } catch (e) {
      print("No contract was found!");
    }
    return contract;
  }

  Future<String?> getTokenSymbolByName(String tokenName) async {
    String symbol = '';
    try {
      final file = await readFile();
      await file.forEach((key, value) {
        if (key == tokenName) {
          List args = value.split(',');
          symbol = args[0];
        }
      });
    } catch (e) {
      print("No token symbol was found!");
    }
    return symbol;
  }

  Future<int?> getTokenDecimalsByName(String tokenName) async {
    int decimals = 0;
    try {
      final file = await readFile();
      await file.forEach((key, value) {
        if (key == tokenName) {
          List args = value.split(',');
          decimals = int.parse(args[2]);
        }
      });
    } catch (e) {
      print("No token symbol was found");
    }
    return decimals;
  }

  Future<String?> getTokenNameByContract(String address) async {
    String name = '';
    try {
      final file = await readFile();
      await file.forEach((key, value) {
        List args = value.split(',');
        if (args[1] == address) {
          name = key;
        }
      });
    } catch (e) {
      print("No name was found!");
    }
    return name;
  }

  Future<String?> getTokenSymbolByContract(String address) async {
    String symbol = '';
    try {
      final file = await readFile();
      await file.forEach((key, value) {
        List args = value.split(',');
        if (args[1] == address) {
          symbol = args[0];
        }
      });
    } catch (e) {
      print("No symbol was found!");
    }
    return symbol;
  }

  Future<int?> getTokenDecimalsByContract(String address) async {
    int decimals = 0;
    try {
      final file = await readFile();
      await file.forEach((key, value) {
        List args = value.split(',');
        if (args[1] == address) {
          decimals = int.parse(args[2]);
        }
      });
    } catch (e) {
      print("No decimals was found");
    }
    return decimals;
  }

  Future<int?> deleteFile() async {
    try {
      final file = await _jsonFile;

      await file.delete();
    } catch (e) {
      return 0;
    }
  }
}
