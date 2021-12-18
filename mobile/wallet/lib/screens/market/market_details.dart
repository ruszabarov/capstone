import 'package:flutter/material.dart';
import 'package:wallet/screens/market/api.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MarketDetailsPage extends StatefulWidget {
  final String coinName;

  MarketDetailsPage(this.coinName);

  @override
  State<MarketDetailsPage> createState() => _MarketDetailsPageState();
}

class _MarketDetailsPageState extends State<MarketDetailsPage> {
  late var data = <LinearPrice>[];
  int decimalPlaces = 0;
  double minPrice = 0;
  double maxPrice = 0;
  late TrackballBehavior _trackballBehavior;
  late ValueNotifier<String> currentCoinPrice;

  @override
  void initState() {
    super.initState();
    currentCoinPrice = ValueNotifier<String>("\$0");
    _getCoinData(1);
    _trackballBehavior = TrackballBehavior(
      enable: true,
      tooltipSettings: InteractiveTooltip(enable: false),
    );
  }

  _getCoinData(int days) async {
    data = [];

    List prices = await getMarketData(widget.coinName, days);
    minPrice = prices[0][1];
    maxPrice = prices[0][1];

    prices.forEach((price) {
      data.add(
          LinearPrice(DateTime.fromMillisecondsSinceEpoch(price[0]), price[1]));

      if (price[1] < minPrice) {
        minPrice = price[1];
      } else if (price[1] > maxPrice) {
        maxPrice = price[1];
      }
    });

    double price = await getCoinData(widget.coinName)
        .then((value) => value['current_price']);
    currentCoinPrice = ValueNotifier<String>(price.toString());

    String priceString = price.toString();
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
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ValueListenableBuilder(
                  valueListenable: currentCoinPrice,
                  builder: (context, value, child) => Text(
                    value.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: SfCartesianChart(
              trackballBehavior: _trackballBehavior,
              onTrackballPositionChanging: (TrackballArgs args) {
                currentCoinPrice.value = args
                    .chartPointInfo.chartDataPoint!.yValue
                    .toStringAsFixed(decimalPlaces);
              },
              primaryXAxis: DateTimeAxis(
                isVisible: false,
              ),
              primaryYAxis: NumericAxis(
                isVisible: false,
                minimum: minPrice - minPrice * 0.1,
                maximum: maxPrice + maxPrice * 0.1,
              ),
              zoomPanBehavior: ZoomPanBehavior(
                  enablePinching: true,
                  enablePanning: true,
                  zoomMode: ZoomMode.x),
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

  @override
  void dispose() {
    currentCoinPrice.dispose();
    super.dispose();
  }
}

class LinearPrice {
  final DateTime date;
  final double price;

  LinearPrice(this.date, this.price);
}
