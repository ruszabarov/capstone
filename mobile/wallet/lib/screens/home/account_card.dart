import 'package:flutter/material.dart';
import 'package:wallet/screens/shared/card.dart';

class AccountCard extends StatefulWidget {
  final String name;
  final String address;
  final double balance;
  final bool accountSelected;

  const AccountCard(
      this.name, this.address, this.balance, this.accountSelected);

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      width: 200,
      height: 150,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: widget.accountSelected ? Colors.grey[350] : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.address,
                //TODO: show fist few and last few characters of the address
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Text(
            "\$ ${widget.balance.toString()}",
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}
