import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/providers/Market.dart';
import 'package:wallet/screens/market/api.dart';
import 'package:wallet/screens/market/market.dart';
import 'package:wallet/screens/market/market_details.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:wallet/wallet_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MarketCard extends StatefulWidget {
  final int myIndex;
  final int lastIndex;

  MarketCard(this.myIndex, this.lastIndex);

  @override
  State<MarketCard> createState() => _MarketCardState();
}

class _MarketCardState extends State<MarketCard> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketList>(
      builder: (context, value, child) => InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MarketDetailsPage(value.markets[widget.myIndex].name)),
          );
        },
        borderRadius: BorderRadius.vertical(
          top: widget.myIndex == 0 ? Radius.circular(10) : Radius.circular(0),
          bottom: widget.myIndex == widget.lastIndex
              ? Radius.circular(10)
              : Radius.circular(0),
        ),
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
                          child: Image.asset(
                              value.markets[widget.myIndex].iconURL),
                        ),
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value.markets[widget.myIndex].name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "\$${value.markets[widget.myIndex].currentPrice.toString()}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: value.markets[widget.myIndex]
                                            .priceChangePercent >
                                        0
                                    ? Colors.green
                                    : Colors.red),
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/*
card(
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
                        child: Image.asset(widget.token.imagePath),
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.token.name,
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
                                text:
                                    "\$${widget.token.currentPrice.toString()}",
                                style: TextStyle(
                                    color: widget.token.isPriceGoingUp
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
      ), */