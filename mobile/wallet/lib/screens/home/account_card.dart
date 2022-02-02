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
  @override
  Widget build(BuildContext context) {
    return Ink(
      // width: MediaQuery.of(context).size.width * 0.7,
      height: 150,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: /*widget.accountSelected ? Colors.grey[350] : */ Colors.white,
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
