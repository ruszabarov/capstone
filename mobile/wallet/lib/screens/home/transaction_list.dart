import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:wallet/screens/home/test_data.dart';
import 'package:wallet/screens/home/receipt_card.dart';
import 'package:wallet/configuration_service.dart';
import 'dart:math';

class TransactionList extends StatelessWidget {
  final List<dynamic> transactions;
  final String myAddress;
  final Token token;
  final Function handleReceiptButton;

  const TransactionList(
      this.transactions, this.handleReceiptButton, this.myAddress, this.token);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 10,
        );
      },
      itemCount: transactions.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return NeumorphicButton(
          style: NeumorphicStyle(
            color: Colors.grey[200],
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(15),
            ),
            depth: 4,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: Colors.grey[200],
                    insetPadding: EdgeInsets.all(20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: SendTransactionCard(
                            handleReceiptButton,
                            transactions[index],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  transactions[index].from == myAddress
                      ? Icon(
                          Icons.arrow_upward,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.arrow_downward,
                          color: Colors.green,
                        ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${double.parse(transactions[index].value) / pow(10, 18)} ${token.symbol}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    transactions[index].timeStamp,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
