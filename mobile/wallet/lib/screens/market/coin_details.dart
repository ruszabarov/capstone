import 'package:flutter/material.dart';
import 'package:wallet/screens/market/api.dart';
import 'package:wallet/screens/market/market_chart.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

class CoinDetailsPage extends StatefulWidget {
  final String coinName;

  CoinDetailsPage(this.coinName);

  @override
  State<CoinDetailsPage> createState() => _CoinDetailsPageState();
}

class _CoinDetailsPageState extends State<CoinDetailsPage> {
  List<charts.Series<LinearPrice, DateTime>> seriesList = [];
  num minPrice = 0;
  num maxPrice = 100000;

  @override
  void initState() {
    super.initState();
    _getCoinData(1);
  }

  _getCoinData(int days) async {
    List prices = await getMarketData(widget.coinName, days);
    var data = <LinearPrice>[];
    num min = 100000;
    num max = 0;

    prices.forEach((price) {
      data.add(
          LinearPrice(DateTime.fromMillisecondsSinceEpoch(price[0]), price[1]));

      if (price[1] < min) {
        min = price[1];
      }
      if (price[1] > max) {
        max = price[1];
      }
    });

    setState(() {
      minPrice = min;
      maxPrice = max;

      seriesList = [
        new charts.Series<LinearPrice, DateTime>(
          id: 'Prices',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (LinearPrice prices, _) => prices.date,
          measureFn: (LinearPrice prices, _) => prices.price,
          data: data,
        )
      ];
    });
  }

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
      body: Column(
        children: [
          Container(
            height: 480,
            width: 390,
            child: SimpleLineChart(seriesList, false, maxPrice, minPrice),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  _getCoinData(1);
                },
                child: Text("1D"),
              ),
              TextButton(
                onPressed: () {
                  _getCoinData(7);
                },
                child: Text("1W"),
              ),
              TextButton(
                onPressed: () {
                  _getCoinData(30);
                },
                child: Text("1M"),
              ),
              TextButton(
                onPressed: () {
                  _getCoinData(90);
                },
                child: Text("3M"),
              ),
              TextButton(
                onPressed: () {
                  _getCoinData(365);
                },
                child: Text("1Y"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LinearPrice {
  final DateTime date;
  final double price;

  LinearPrice(this.date, this.price);
}
