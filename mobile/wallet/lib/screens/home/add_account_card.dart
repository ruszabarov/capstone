import 'package:flutter/material.dart';
import 'package:wallet/screens/shared/card.dart';
import 'dart:math';

class AddAccountCard extends StatefulWidget {
  const AddAccountCard();

  @override
  State<AddAccountCard> createState() => _AddAccountCardState();
}

class _AddAccountCardState extends State<AddAccountCard> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      // width: MediaQuery.of(context).size.width * 0.7,
      height: 150,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            Colors.blueGrey,
            Colors.grey,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: Offset(5, 5),
            blurRadius: 3,
          ),
        ],
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
                "Add Account",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
