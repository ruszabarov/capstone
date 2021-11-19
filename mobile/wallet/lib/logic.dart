import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:wallet/screens/authentication/login.dart';
import 'package:wallet/screens/wrapper.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:web3dart/web3dart.dart';

bool data = false;
int myAmount = 0;
final myAddress = "0x127Ff1D9560F7992911389BA181f695b38EE9399";

var myData;
Client httpClient = Client();
Web3Client ethClient = Web3Client("https://rinkeby.infura.io/v3/38ba5f4475644e4ba48d25313c80347b", httpClient);

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/build/contracts/abi.json");
    String contractAddress = "0x2B067c28D03C84563Dab3A92767c473f8e2235a9";

    final contract = DeployedContract(ContractAbi.fromJson(abi, "Ethereum"), EthereumAddress.fromHex(contractAddress));

     return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(contract: contract, function: ethFunction, params: args);

    return result;
  }

  Future<dynamic> getBalance(String targetAddress) async {
    // EthereumAddress address = EthereumAddress.fromHex(targetAddress);
    List<dynamic> result = await query("getBalance", []);

    myData = result[0];
    data = true;
    return result;
  }
