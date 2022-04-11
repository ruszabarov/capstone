import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
      builder: (context, value, child) => NeumorphicButton(
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MarketDetailsPage(value.markets[widget.name]!.name),
            ),
          );
        },
        duration: Duration(milliseconds: 100),
        style: NeumorphicStyle(
          color: Colors.grey[200],
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
          depth: 4,
        ),
        padding: const EdgeInsets.all(20),
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
                        child: Image.asset(value.markets[widget.name]!.iconURL),
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
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
