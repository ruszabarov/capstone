import 'package:flutter/material.dart';
import 'package:wallet/screens/market/api.dart';
import 'package:wallet/screens/market/market_chart.dart';
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
  late double lastPrice = 0;

  @override
  void initState() {
    super.initState();
    currentCoinPrice = ValueNotifier<String>("0");
    _getCoinData('1');
    _trackballBehavior = TrackballBehavior(
      enable: true,
      tooltipSettings: InteractiveTooltip(enable: false),
    );
  }

  _getCoinData(String days) async {
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

    lastPrice = await getCoinData(widget.coinName)
        .then((value) => value['current_price']);
    currentCoinPrice = ValueNotifier<String>(lastPrice.toString());

    String priceString = lastPrice.toString();
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
                    "\$ ${value.toString()}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          MarketChart(_trackballBehavior, currentCoinPrice, minPrice, maxPrice,
              data, decimalPlaces, lastPrice),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimeRangeButton(
                  days: '1', label: "1D", getCoinData: _getCoinData),
              TimeRangeButton(
                  days: '7', label: "1W", getCoinData: _getCoinData),
              TimeRangeButton(
                  days: '30', label: "1M", getCoinData: _getCoinData),
              TimeRangeButton(
                  days: '90', label: "3M", getCoinData: _getCoinData),
              TimeRangeButton(
                  days: '365', label: "1Y", getCoinData: _getCoinData),
              TimeRangeButton(
                  days: 'max', label: "All", getCoinData: _getCoinData),
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

class TimeRangeButton extends StatelessWidget {
  final String days;
  final String label;
  final Function getCoinData;
  const TimeRangeButton(
      {Key? key,
      required this.days,
      required this.label,
      required this.getCoinData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        getCoinData(days);
      },
      child: Text(label),
    );
  }
}
