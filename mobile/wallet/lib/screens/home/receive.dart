import 'package:flutter/material.dart';
import 'package:wallet/screens/home/test_data.dart';
import 'package:wallet/screens/shared/shared.dart';

class ReceiveCard extends StatelessWidget {
  final CryptoWallet cryptoWallet;
  final Function handleReceiveButton;

  const ReceiveCard(
      {Key? key,
      required this.cryptoWallet,
      required Function this.handleReceiveButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Deposit ${cryptoWallet.shortName}",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () {
                    handleReceiveButton();
                  },
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                )
              ],
            ),
            Divider(
              thickness: 3,
              height: 40,
              color: Colors.white,
            ),
            Text(
              "Wallet Address",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent, width: 2),
                  color: Colors.blue.shade900.withOpacity(0.2)),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cryptoWallet.adress,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    child: Icon(
                      Icons.copy,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
