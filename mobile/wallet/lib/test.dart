import 'package:http/http.dart';
import 'package:wallet/private.dart';
import 'package:web3dart/web3dart.dart';

final myAddress = "0x127Ff1D9560F7992911389BA181f695b38EE9399";
EthereumAddress myAddress1 = EthereumAddress.fromHex(myAddress);

Client httpClient = new Client();
Web3Client ethClient = new Web3Client("https://ropsten.infura.io/v3/38ba5f4475644e4ba48d25313c80347b", httpClient);

Future<dynamic> balance = ethClient.getBalance(EthereumAddress.fromHex(myAddress));