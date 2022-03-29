import 'dart:convert';
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
  Uri url = Uri.parse("https://api.blocknative.com/gasprices/blockprices");


dynamic estimateGas() async {
  var response = await http.get(url, headers: {HttpHeaders.authorizationHeader: gasKey});
  dynamic json = jsonDecode(response.body);
  List<int> estimates = [];
  for(int i = 0; i < json["blockPrices"][0]["estimatedPrices"]);
  // estimates.add(json["blockPrices"]["estimatedPrices"][0].confidence);
  return json["blockPrices"][0]["estimatedPrices"][0]["confidence"];
}


void getReceipt(String txhash) async {
  // await next block and make a call for the receipt if status is 1 then transaction succeeded

  dynamic abc = etherscan.getStatus(txhash: txhash);
  // dynamic abcc = etherscan.tx;
}
