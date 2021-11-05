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
        SizedBox(
          height: 25,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: new ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 15,
                );
              },
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: cryptoWallets.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return new WalletCard(cryptoWallets[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
