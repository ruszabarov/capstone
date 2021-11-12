import 'package:flutter/material.dart';
import 'package:wallet/screens/home/test_data.dart';
import 'package:wallet/screens/shared/shared.dart';

class WalletDetailsPage extends StatelessWidget {
  final CryptoWallet cryptoWallet;

  WalletDetailsPage(this.cryptoWallet);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: appBar(
          title: cryptoWallet.name[0].toUpperCase() +
              cryptoWallet.name.substring(1) +
              ' Wallet',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        cryptoWallet.icon,
                        color: Colors.black,
                        size: 35.0,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          cryptoWallet.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      // Text('$cryptoShort')
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    cryptoWallet.balance + " " + cryptoWallet.shortName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black87),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _actionButton(
                    text: 'Send',
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: _actionButton(
                    text: 'Receive',
                    color: Colors.pink,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton({required Color color, required String text}) {
    return card(
      child: Column(
        children: [
          ClipOval(
            child: Material(
              color: color,
              child: InkWell(
                splashColor: Colors.white, // inkwell color
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(
                    Icons.attach_money,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
          SizedBox(height: 10),
          Text('$text', style: TextStyle(fontSize: 24, color: Colors.black54))
        ],
      ),
    );
  }
}
