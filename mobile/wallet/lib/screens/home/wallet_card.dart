import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  final String title;
  final String balance;
  final IconData icon;

  WalletCard(this.title, this.balance, this.icon);

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
                title.toUpperCase(),
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
                balance.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                onPressed: () {},
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
