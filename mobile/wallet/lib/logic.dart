import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:wallet/screens/authentication/login.dart';
import 'package:wallet/screens/wrapper.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:web3dart/web3dart.dart';


late Client httpClient;
late Web3Client ethClient;
bool data = false;
int myAmount = 0;
final myAddress = "0x127Ff1D9560F7992911389BA181f695b38EE9399";

var myData;

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client("http://127.0.0.1:7545", httpClient);

    getBalance(myAddress);
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/build/contracts/Migrations.json");
    String contractAddress = "0x4715f0D65B077af6FFac398673F22683712DE43A";

    final contract = DeployedContract(ContractAbi.fromJson(abi, "Ethereum"), EthereumAddress.fromHex(contractAddress));

     return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(contract: contract, function: ethFunction, params: args);

    return result;
  }

  Future<void> getBalance(String targetAddress) async {
    EthereumAddress address = EthereumAddress.fromHex(targetAddress);
    List<dynamic> result = await query("getBalance", []);

    myData = result[0];
    data = true;
  }
