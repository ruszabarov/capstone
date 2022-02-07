import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/providers/Market.dart';
import 'package:wallet/screens/market/market_details.dart';
import 'package:wallet/screens/shared/shared.dart';

class MarketCard extends StatefulWidget {
  final int myIndex;
  final int lastIndex;
  final String name;

  MarketCard(this.myIndex, this.lastIndex, this.name);

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
              builder: (context) => MarketDetailsPage(widget.name),
            ),
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
                          child:
                              Image.asset(value.markets[widget.name]!.iconURL),
                        ),
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value.markets[widget.name]!.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "\$${value.markets[widget.name]!.currentPrice.toString()}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: value.markets[widget.name]!
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
