import 'package:flutter/material.dart';
import 'package:wallet/screens/market/api.dart';
import 'package:wallet/screens/market/market_chart.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CoinDetailsPage extends StatefulWidget {
  CoinDetailsPage();

  @override
  State<CoinDetailsPage> createState() => _CoinDetailsPageState();
}

class _CoinDetailsPageState extends State<CoinDetailsPage> {
  List<charts.Series<LinearPrice, DateTime>> seriesList = [];

  @override
  void initState() {
    _getCoinData();
    super.initState();
  }

  _getCoinData() async {
    List prices = await getMarketData('bitcoin', 1);
    var data = <LinearPrice>[];

    prices.forEach((price) {
      print("${DateTime.fromMillisecondsSinceEpoch(price[0])} + ${price[1]}");
      data.add(
          LinearPrice(DateTime.fromMillisecondsSinceEpoch(price[0]), price[1]));
    });

    seriesList = [
      new charts.Series<LinearPrice, DateTime>(
        id: 'Prices',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearPrice prices, _) => prices.date,
        measureFn: (LinearPrice prices, _) => prices.price,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    print("buidling");
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: appBar(
          title: 'Coin',
        ),
      ),
      body: Container(
        width: 500,
        height: 500,
        child: SimpleLineChart(seriesList),
      ),
    );
  }
}

class LinearPrice {
  final DateTime date;
  final double price;

  LinearPrice(this.date, this.price);
}
