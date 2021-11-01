import 'package:flutter/material.dart';
import 'test_data.dart';
import 'wallet_card.dart';

class Home extends StatelessWidget {
  final String title = "Portfolio";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        new Expanded(
          child: new ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: cryptoWallets.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return new WalletCard(cryptoWallets[index]);
              }),
        )
      ],
    );
  }
}
