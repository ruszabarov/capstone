import 'package:flutter/material.dart';
import 'package:wallet/screens/shared/card.dart';

class AccountCard extends StatefulWidget {
  final String name;
  final String address;
  final double balance;

  const AccountCard(this.name, this.address, this.balance);

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  bool accountSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {},
      child: Ink(
        width: 200,
        height: 150,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color: Colors.white,
            width: 5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.name),
            SizedBox(
              height: 10,
            ),
            Text(widget.address),
            SizedBox(
              height: 55,
            ),
            Text(widget.balance.toString())
          ],
        ),
      ),
    );
  }
}
