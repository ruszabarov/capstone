import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:wallet/screens/authentication/login.dart';
import 'package:wallet/screens/wrapper.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:web3dart/web3dart.dart';

bool data = false;
int myAmount = 3;
final myAddress = "0x127Ff1D9560F7992911389BA181f695b38EE9399";

var myData;
Client httpClient = Client();
Web3Client ethClient = Web3Client("https://rinkeby.infura.io/v3/38ba5f4475644e4ba48d25313c80347b", httpClient);

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/build/contracts/abi.json");
    String contractAddress = "0x294e0287B83DD6f5b177C631A0636C04c4C5b8f4";

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
    return myData.toString();
  }

  Future<String> withdrawCoin() async {
    var bigAmount = BigInt.from(myAmount);
    var response = await submit("withdrawBalance",[bigAmount]);
    return response;
  }

  Future<String> submit(String funtionName, List<dynamic> args) async {
    EthPrivateKey credential = EthPrivateKey.fromHex("hex");
    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(funtionName);
    final result = await ethClient.sendTransaction(credential, Transaction.callContract(contract: contract, function: ethFunction,
     parameters: args, maxGas: 100000), chainId: 4);
    
    return result;
  }
