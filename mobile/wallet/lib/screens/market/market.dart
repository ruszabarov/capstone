import 'package:flutter/material.dart';
import 'market_card.dart';
import 'package:http/http.dart' as http;

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  var marketList = [
    'ethereum',
    'tether',
    'usd-coin',
    'matic-network',
    'shiba-inu',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: new ListView.separated(
            padding: EdgeInsets.all(25),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 15,
              );
            },
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: marketList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return new MarketCard(marketList[index]);
            },
          ),
        ),
      ],
    );
  }
}
