import 'package:flutter/material.dart';
import 'test_data.dart';
import 'wallet_card.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            itemCount: cryptoWallets.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return new WalletCard(cryptoWallets[index]);
            },
          ),
        ),
      ],
    );
  }
}
