import 'package:flutter/material.dart';
import 'package:wallet/screens/market/market_chart.dart';
import 'package:wallet/screens/shared/shared.dart';

class CoinDetailsPage extends StatefulWidget {
  CoinDetailsPage();

  @override
  State<CoinDetailsPage> createState() => _CoinDetailsPageState();
}

class _CoinDetailsPageState extends State<CoinDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: appBar(
          title: 'Coin',
        ),
      ),
      body: SimpleLineChart.withRandomData(),
    );
  }
}
