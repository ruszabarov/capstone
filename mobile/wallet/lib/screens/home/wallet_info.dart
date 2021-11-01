import 'package:flutter/material.dart';
import 'package:wallet/screens/home/test_data.dart';

class WalletInfoPage extends StatelessWidget {
  final CryptoWallet cryptoWallet;

  WalletInfoPage(this.cryptoWallet);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet"),
      ),
      body: Column(
        children: [Text("hi")],
      ),
    );
  }
}
