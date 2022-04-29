import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wallet/screens/home/test_data.dart';
import 'package:decimal/decimal.dart';

class SendTransactionCard extends StatelessWidget {
  final Function exitFunction;
  final dynamic transaction;
  SendTransactionCard(this.exitFunction, this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  //! transaction.type == "outgoing" ? "Send" : "Receive",
                  "Transaction",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    exitFunction();
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "From",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "To",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    transaction.from,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Icon(Icons.arrow_right),
                Flexible(
                  child: Text(
                    transaction.to,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Transaction",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("Nonce"),
            //     Text(transaction.nonce.toString()),
            //   ],
            // ),
            Divider(
              height: 20,
              thickness: 1,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Amount"),
                Text("${double.parse(transaction.value) / pow(10, 18)}  ETH"),
              ],
            ),
            spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Gas Price (WEI)"),
                Text(transaction.gasPrice.toString()),
              ],
            ),
            spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Gas Used (WEI)"),
                Text(transaction.gasUsed.toString()),
              ],
            ),
            spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Time Stamp"),
                Text(transaction.timeStamp.toString()),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("Base Fee (GWEI)"),
            //     Text(
            //       Decimal.parse(transaction.gasPrice.toString()).toString(),
            //     ),
            //   ],
            // ),
            // spacer(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("Priority Fee (GWEI)"),
            //     Text(transaction.priorityFee.toString()),
            //   ],
            // ),
            // spacer(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("Total Gas Fee"),
            //     Text(
            //       Decimal.parse(transaction.totalGasFee.toString()).toString(),
            //     ),
            //   ],
            // ),
            // spacer(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("Max Fee Per Gas"),
            //     Text(Decimal.parse(transaction.maxFeePerGas.toString())
            //         .toString()),
            //   ],
            // ),
            // Divider(
            //   height: 20,
            //   thickness: 1,
            //   color: Colors.grey,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("Total"),
            //     Text(
            //       "${transaction.total} ETH",
            //       style: TextStyle(fontWeight: FontWeight.bold),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

Widget spacer() {
  return SizedBox(
    height: 5,
  );
}
