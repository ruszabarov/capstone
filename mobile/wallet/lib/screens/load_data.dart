import 'package:flutter/material.dart';
import 'package:wallet/logic.dart';
import 'package:wallet/providers/Account.dart';
import 'package:wallet/providers/Token.dart';
import 'package:wallet/providers/Market.dart';
import 'package:wallet/screens/market/api.dart';
import 'package:wallet/screens/wrapper.dart';

class LoadDataPage extends StatefulWidget {
  LoadDataPage({Key? key}) : super(key: key);

  @override
  State<LoadDataPage> createState() => _LoadDataPageState();
}

class _LoadDataPageState extends State<LoadDataPage> {
  //! initAccountData is in Token.dart with dummy data
  //! initMarketData is in Market.dart with dummy data

  void loadData() async {
    // load Account data
    for (int i = 0; i < initAccountData[0].tokens.tokenList.length; i++) {
      initAccountData[0].tokens.tokenList[i].balance = double.parse(
          await getTokenBalance(initAccountData[0].address, "ChainLink Token"));
    }

    print(initMarketData);

    // load Market data
    String request = "";
    initMarketData.keys.forEach((key) {
      request += "$key,";
    });

    Map<String, dynamic> response = await getSimpleTokenData(request);

    initMarketData.values.forEach((value) {
      value.currentPrice = response[value.name]['usd'];
      value.priceChangePercent = response[value.name]['usd_24h_change'];
    });

    await Future.delayed(Duration(seconds: 2));

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return Wrapper(initAccountData, initMarketData);
        },
      ),
    );
  }

  @override
  void initState() {
    print("built");
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
