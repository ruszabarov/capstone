import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wallet/screens/market/api.dart';
import 'package:wallet/screens/market/coin_details.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:wallet/wallet_icons.dart';

class MarketCard extends StatefulWidget {
  final String marketName;

  MarketCard(this.marketName);

  @override
  State<MarketCard> createState() => _MarketCardState();
}

class _MarketCardState extends State<MarketCard> {
  double price = 0.0;
  bool priceGoingUp = true;
  Timer? timer;

  @override
  initState() {
    updateValues();
    super.initState();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) {
      updateValues();
    });
  }

  updateValues() async {
    Map<String, dynamic> data = await getCoinData(widget.marketName);

    setState(() {
      price = data['current_price'];
      priceGoingUp = data['price_change_percent'] > 0 ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CoinDetailsPage()),
        );
      },
      borderRadius: BorderRadius.circular(15),
      child: card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Material(
                        color: Colors.black87,
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Wallet.ethereum,
                            color: Colors.white,
                            size: 25.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.marketName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            text: "Current: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                            children: [
                              TextSpan(
                                text: "\$${price.toString()}",
                                style: TextStyle(
                                    color: priceGoingUp
                                        ? Colors.green
                                        : Colors.red),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.keyboard_arrow_right),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
