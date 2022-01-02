import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wallet/screens/market/api.dart';
import 'package:wallet/screens/market/market_details.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:wallet/wallet_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MarketCard extends StatefulWidget {
  final String marketName;

  MarketCard(this.marketName);

  @override
  State<MarketCard> createState() => _MarketCardState();
}

class _MarketCardState extends State<MarketCard> {
  double price = 0.0;
  bool priceGoingUp = true;
  late String imageURL = '';
  Timer? timer;

  @override
  initState() {
    super.initState();
    updateValues();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) {
      updateValues();
    });
  }

  updateValues() async {
    Map<String, dynamic> data = await getCoinData(widget.marketName);

    setState(() {
      price = data['current_price'];
      priceGoingUp = data['price_change_percent'] > 0 ? true : false;
      imageURL = data['icon'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MarketDetailsPage(widget.marketName)),
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
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: imageURL == ''
                            ? CircularProgressIndicator()
                            : CachedNetworkImage(
                                imageUrl: '$imageURL',
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
