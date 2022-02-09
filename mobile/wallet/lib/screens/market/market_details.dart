import 'package:flutter/material.dart';
import 'package:wallet/screens/market/api.dart';
import 'package:wallet/screens/market/market_chart.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

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
  double priceChangeInRange = 0;
  double percentChangeInRange = 0;
  late TrackballBehavior _trackballBehavior;
  late ValueNotifier<String> currentCoinPrice;
  late ValueNotifier<DateTime> currentDate;
  late double lastPrice = 0;
  bool displayMinutes = true;
  bool displayHours = false;
  bool chartLoaded = false;

  @override
  void initState() {
    super.initState();
    currentCoinPrice = ValueNotifier<String>("0");
    currentDate = ValueNotifier<DateTime>(DateTime.now());
    _getCoinData(1);
    _trackballBehavior = TrackballBehavior(
      enable: true,
      tooltipSettings: InteractiveTooltip(enable: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Ink(
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.coinName,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 20),
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
                  SizedBox(
                    width: 15,
                  ),
                  ValueListenableBuilder(
                      valueListenable: currentDate,
                      builder: (context, DateTime value, child) {
                        if (displayMinutes) {
                          return Text(
                            DateFormat().add_jm().format(value),
                            style: TextStyle(fontSize: 20),
                          );
                        } else if (displayHours) {
                          return Text(
                            DateFormat('MMM d, yyyy h a').format(value),
                            style: TextStyle(fontSize: 20),
                          );
                        } else {
                          return Text(
                            DateFormat('MMM d, yyyy').format(value),
                            style: TextStyle(fontSize: 20),
                          );
                        }
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${priceChangeInRange.toStringAsFixed(2)} (${percentChangeInRange.toStringAsFixed(2)}%)',
                    style: TextStyle(
                        color: percentChangeInRange >= 0
                            ? Colors.green
                            : Colors.red),
                  ),
                ],
              ),
            ),
            chartLoaded == true
                ? MarketChart(_trackballBehavior, currentCoinPrice, minPrice,
                    maxPrice, data, decimalPlaces, lastPrice, currentDate)
                : Container(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TimeRangeButton(
                      days: 1, label: "1D", getCoinData: _getCoinData),
                  TimeRangeButton(
                      days: 7, label: "1W", getCoinData: _getCoinData),
                  TimeRangeButton(
                      days: 30, label: "1M", getCoinData: _getCoinData),
                  TimeRangeButton(
                      days: 90, label: "3M", getCoinData: _getCoinData),
                  TimeRangeButton(
                      days: 365, label: "1Y", getCoinData: _getCoinData),
                  TimeRangeButton(
                      days: -1, label: "All", getCoinData: _getCoinData),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    currentCoinPrice.dispose();
    super.dispose();
  }

  _getCoinData(int days) async {
    chartLoaded = false;
    data = [];

    if (days == 1) {
      displayMinutes = true;
      displayHours = false;
    } else if (days <= 30 && days != -1) {
      displayHours = true;
      displayMinutes = false;
    } else {
      displayMinutes = false;
      displayHours = false;
    }

    List prices = await getMarketData(widget.coinName, days);

    _calculateBounds(prices);

    lastPrice = await getSimpleTokenData(widget.coinName)
        .then((value) => value[widget.coinName]['usd']);

    //Calculate decimal palces
    String priceString = lastPrice.toString();
    for (int i = 0; i < priceString.length; i++) {
      decimalPlaces++;
      if (priceString[i] == '.') {
        decimalPlaces = 0;
      }
    }

    currentCoinPrice =
        ValueNotifier<String>(lastPrice.toStringAsFixed(decimalPlaces));

    _calculatePriceChange(prices);

    chartLoaded = true;
    setState(() {});
  }

  _calculateBounds(List prices) {
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
  }

  _calculatePriceChange(List prices) {
    double firstPrice = prices[0][1];
    double lastPrice = prices.last[1];

    priceChangeInRange = lastPrice - firstPrice;
    percentChangeInRange = (lastPrice / firstPrice) * 100 - 100;
  }
}

class TimeRangeButton extends StatelessWidget {
  final int days;
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
    return InkWell(
      onTap: () {
        getCoinData(days);
      },
      borderRadius: BorderRadius.circular(5),
      child: Ink(
        height: 30,
        width: 40,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(color: Colors.blue[600]),
          ),
        ),
      ),
    );
  }
}
