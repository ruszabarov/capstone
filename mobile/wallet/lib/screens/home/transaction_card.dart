import 'package:flutter/material.dart';

class SendTransactionCard extends StatelessWidget {
  Function exitFunction;
  SendTransactionCard(this.exitFunction);

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
                Text("Send"),
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
              children: [
                Text("0xafl232alkjalk5223"),
                Icon(Icons.arrow_right),
                Text("0xlgji23auyten,8721"),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Nonce"),
                Text("0"),
              ],
            ),
            Divider(
              height: 20,
              thickness: 1,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Amount"),
                Text("-0.02 ETH"),
              ],
            ),
            spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Gas Limit (Units)"),
                Text("21000"),
              ],
            ),
            spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Gas Used (Units)"),
                Text("21000"),
              ],
            ),
            spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Base Fee (GWEI)"),
                Text("0.000000015"),
              ],
            ),
            spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Priority Fee (GWEI)"),
                Text("1.5"),
              ],
            ),
            spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Gas Fee"),
                Text("0.000031 ETH"),
              ],
            ),
            spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Max Fee Per Gas"),
                Text("0.000000002"),
              ],
            ),
            Divider(
              height: 20,
              thickness: 1,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total"),
                Text(
                  "0.0200315 ETH",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
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
