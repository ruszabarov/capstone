import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet/configuration_service.dart';
import 'package:wallet/providers/Market.dart';
import 'package:wallet/providers/Token.dart';
import 'package:wallet/screens/market/api.dart';
import 'package:wallet/screens/wrapper.dart';
import 'package:wallet/wallet_setup.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadDataPage extends StatefulWidget {
  LoadDataPage({Key? key}) : super(key: key);

  @override
  State<LoadDataPage> createState() => _LoadDataPageState();
}

class _LoadDataPageState extends State<LoadDataPage> {
  void loadData() async {
    // load Account data
    ConfigurationService configurationService =
        context.read<ConfigurationService>();

    SharedPreferences _preferences = await SharedPreferences.getInstance();

    if (await _preferences.getString('asd') == null ||
        await _preferences.getString('asd') == "[]") {
      await configurationService.firstAccount("first");
    }

    // load Market data
    String request = "";
    initMarketData.forEach((key, value) {
      request += "${value.name},";
    });

    Map<String, dynamic> response = await getSimpleTokenData(request);

    initMarketData.forEach((key, value) {
      value.currentPrice = response[value.name]['usd'];
      value.priceChangePercent = response[value.name]['usd_24h_change'];
    });

    await Future.delayed(Duration(seconds: 2));

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return Wrapper(initMarketData);
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
