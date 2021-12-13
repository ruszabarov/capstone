import 'package:flutter/material.dart';
import 'package:wallet/screens/market/api.dart';
import 'package:wallet/screens/market/market_chart.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CoinDetailsPage extends StatefulWidget {
  final String coinName;

  CoinDetailsPage(this.coinName);

  @override
  State<CoinDetailsPage> createState() => _CoinDetailsPageState();
}

class _CoinDetailsPageState extends State<CoinDetailsPage> {
  late var data = <LinearPrice>[];
  int decimalPlaces = 0;

  @override
  void initState() {
    super.initState();
    _getCoinData(1);
  }

  _getCoinData(int days) async {
    data = [];
    List prices = await getMarketData(widget.coinName, days);

    prices.forEach((price) {
      data.add(
          LinearPrice(DateTime.fromMillisecondsSinceEpoch(price[0]), price[1]));
    });

    String priceString = await getCoinData(widget.coinName)
        .then((value) => value['current_price'].toString());
    for (int i = 0; i < priceString.length; i++) {
      decimalPlaces++;
      if (priceString[i] == '.') {
        decimalPlaces = 0;
      }
    }

    setState(() {});
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
            child: SfCartesianChart(
              primaryXAxis: DateTimeAxis(
                isVisible: false,
              ),
              primaryYAxis: NumericAxis(
                isVisible: false,
              ),
              zoomPanBehavior: ZoomPanBehavior(
                  enablePinching: true,
                  enablePanning: true,
                  zoomMode: ZoomMode.x),
              trackballBehavior: TrackballBehavior(
                enable: true,
                tooltipSettings: InteractiveTooltip(
                    enable: true,
                    color: Colors.blueAccent,
                    decimalPlaces: decimalPlaces,
                    format: 'point.x : \$point.y'),
              ),
              title: ChartTitle(text: "Coin Price"),
              series: <FastLineSeries<LinearPrice, DateTime>>[
                FastLineSeries<LinearPrice, DateTime>(
                  // Bind data source
                  dataSource:
                      data.isNotEmpty ? data : [LinearPrice(DateTime.now(), 0)],
                  xValueMapper: (LinearPrice prices, _) => prices.date,
                  yValueMapper: (LinearPrice prices, _) => prices.price,
                )
              ],
            ),
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
