import 'package:flutter/material.dart';
import 'package:wallet/screens/shared/card.dart';

class AccountCard extends StatelessWidget {
  final String name;
  final String address;
  final double balance;

  const AccountCard(this.name, this.address, this.balance);

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: 200,
      height: 150,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name),
          SizedBox(
            height: 10,
          ),
          Text(address),
          SizedBox(
            height: 55,
          ),
          Text(balance.toString())
        ],
      ),
    );
  }
}
