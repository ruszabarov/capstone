import 'package:flutter/material.dart';
import 'package:wallet/logic.dart';
import 'package:wallet/providers/Account.dart';
import 'package:wallet/providers/Token.dart';
import 'package:wallet/screens/wrapper.dart';
import 'package:web3dart/web3dart.dart';

class LoadDataPage extends StatefulWidget {
  LoadDataPage({Key? key}) : super(key: key);

  @override
  State<LoadDataPage> createState() => _LoadDataPageState();
}

Token ethereum = new Token("ethereum", "asdadasds", 'ETH', 0);
Token bitcoin = new Token("bitcoin", "asdasdad", "BTC", 0);

var cryptoWallets = [
  ethereum,
  bitcoin,
];
Account testAccount = Account(
  "asd",
  "0x127Ff1D9560F7992911389BA181f695b38EE9399",
  2250.12,
  TokenList(cryptoWallets),
);

class _LoadDataPageState extends State<LoadDataPage> {
  List<Account> initData = [testAccount];

  void loadData() async {
    for (int i = 0; i < initData[0].tokens.tokenList.length; i++) {
      initData[0].tokens.tokenList[i].balance = double.parse(
          await getTokenBalance(
              EthereumAddress.fromHex(initData[0].address), "ChainLink Token"));
    }

    await Future.delayed(Duration(seconds: 1));

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return Wrapper(initData);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Loading data"),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
