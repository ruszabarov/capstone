import 'dart:convert';
import 'package:wallet/logic.dart';
import 'package:web3dart/web3dart.dart';

import 'private.dart';
import 'package:etherscan_api/etherscan_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

final etherscan =
    EtherscanAPI(apiKey: apiKey, chain: EthChain.rinkeby, enableLogs: false);
final myAddress = "0x127Ff1D9560F7992911389BA181f695b38EE9399";
// Client httpClient = new Client();
Uri url = Uri.parse(
    "https://api.blocknative.com/gasprices/blockprices?confidenceLevels=90&confidenceLevels=75&confidenceLevels=60");

Future<List<Gas>> estimateGas() async {
  var response =
      await http.get(url, headers: {HttpHeaders.authorizationHeader: gasKey});
  dynamic json = jsonDecode(response.body);
  List<Gas> estimates = [];
  for (int i = 0; i < 3; i++) {
    estimates.add(Gas(
        confidence: json["blockPrices"][0]["estimatedPrices"][i]["confidence"],
        price: json["blockPrices"][0]["estimatedPrices"][i]["price"],
        maxPriorityFeePerGas: json["blockPrices"][0]["estimatedPrices"][i]
            ["maxPriorityFeePerGas"],
        maxFeePerGas: json["blockPrices"][0]["estimatedPrices"][i]
            ["maxFeePerGas"]));
  }
  return estimates;
}

Future<TransactionReceipt> getTransactionReceipt(String txHash) async {
  dynamic status = await etherscan.getStatus(txhash: txHash);

  while (status.status == 0) {
    await Future.delayed(Duration(seconds: 15));
    status = await etherscan.getStatus(txhash: txHash);
    print(status.status);
  }

  TransactionReceipt? receipt = await ethClient.getTransactionReceipt(txHash);

  // dynamic acc = ethClient.addedBlocks().listen((event) { abc = etherscan.getStatus(txhash: txHash);});
  return receipt!;
}

Future<List<dynamic>> ethTxHistory(String address) async {
  dynamic ethTx = await etherscan.txList(address: address);
  return ethTx.result;
}

Future<List<dynamic>> tokenTxHistory(
    String address, String tokenAddress) async {
  dynamic tokenTx =
      await etherscan.tokenTx(address: address, contractAddress: tokenAddress);
  return tokenTx.result;
}

class Gas {
  int confidence;
  int price;
  double maxPriorityFeePerGas;
  double maxFeePerGas;

  Gas({
    required this.confidence,
    required this.price,
    required this.maxPriorityFeePerGas,
    required this.maxFeePerGas,
  });

  factory Gas.fromJson(Map<String, dynamic> jsonData) {
    return Gas(
      confidence: jsonData['confidence'],
      price: jsonData['price'],
      maxPriorityFeePerGas: jsonData['maxPriorityFeePerGas'],
      maxFeePerGas: jsonData['maxFeePerGas'],
    );
  }

  static Map<String, dynamic> toMap(Gas gas) => {
        'confidence': gas.confidence,
        'price': gas.price,
        'maxPriorityFeePerGas': gas.maxPriorityFeePerGas,
        'maxFeePerGas': gas.maxFeePerGas,
      };

  static String encode(List<Gas> gases) => json.encode(
        gases.map<Map<String, dynamic>>((gas) => Gas.toMap(gas)).toList(),
      );

  static List<Gas> decode(String? gases) =>
      (json.decode(gases!) as List<dynamic>)
          .map<Gas>((item) => Gas.fromJson(item))
          .toList();
}
