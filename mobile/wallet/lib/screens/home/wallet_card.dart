import 'package:flutter/material.dart';
import 'package:wallet/screens/home/test_data.dart';
import 'package:wallet/screens/home/wallet_info.dart';

class WalletCard extends StatelessWidget {
  final CryptoWallet cryptoWallet;
  WalletCard(this.cryptoWallet);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              SizedBox(width: 10),
              Icon(
                Icons.account_balance_wallet_outlined,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                cryptoWallet.name.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                cryptoWallet.balance.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WalletInfoPage(cryptoWallet)));
                },
                icon: Icon(Icons.arrow_right_rounded),
                iconSize: 50,
              ),
            ],
          )
        ],
      ),
    );
  }
}
