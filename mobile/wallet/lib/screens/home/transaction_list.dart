import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:wallet/screens/home/test_data.dart';
import 'package:wallet/screens/home/receipt_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function handleReceiptButton;

  const TransactionList(this.transactions, this.handleReceiptButton);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: transactions.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return NeumorphicButton(
          style: NeumorphicStyle(
            color: Colors.grey[200],
            shadowLightColor: index == 0 ? Colors.white : Colors.grey.shade200,
            shadowLightColorEmboss:
                index == 0 ? Colors.white : Colors.grey.shade200,
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.vertical(
                top: index == 0 ? Radius.circular(10) : Radius.circular(0),
                bottom: index == transactions.length - 1
                    ? Radius.circular(10)
                    : Radius.circular(0),
              ),
            ),
            depth: 4,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
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
                  transactions[index].type == 'outgoing'
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
                    "${transactions[index].total.toString()} ETH",
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
                    transactions[index].date,
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
