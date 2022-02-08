import 'dart:convert';
import 'private.dart';
import 'package:etherscan_api/etherscan_api.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

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

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/app.json');
}

Future<File> writeCounter(int counter) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsString('$counter');
}

Future<int> readCounter() async {
  try {
    final file = await _localFile;

    // Read the file
    final contents = await file.readAsString();

    return int.parse(contents);
  } catch (e) {
    // If encountering an error, return 0
    return 0;
  }
}

void addToken(String name, String symbol, String address, int decimal) async {
Directory directory = await getApplicationDocumentsDirectory();
var dbPath = join(directory.path, "app.json");
ByteData data = await rootBundle.load("assets/build/contracts/token-list-rinkeby.json");
List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
await File(dbPath).writeAsBytes(bytes);
  // final String abi = await rootBundle.loadString("assets/build/contracts/token-list-rinkeby.json");
  // var json = jsonDecode(abi);
List<dynamic> token = [];
token.add(name);
token.add(symbol);
token.add(address);
token.add(decimal);
print(await File(dbPath).writeAsString(jsonEncode(token)));
  // jsonEncode(token);
  // print(token);
}