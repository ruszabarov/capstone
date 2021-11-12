import 'package:flutter/material.dart';
import 'package:wallet/screens/home/test_data.dart';
import 'package:wallet/screens/home/wallet_details.dart';
import 'package:wallet/screens/shared/shared.dart';

class WalletCard extends StatelessWidget {
  final CryptoWallet cryptoWallet;
  WalletCard(this.cryptoWallet);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WalletDetailsPage(cryptoWallet)),
        );
      },
      borderRadius: BorderRadius.circular(15),
      child: card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipOval(
                  child: Material(
                    color: Colors.black87,
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(
                        cryptoWallet.icon,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cryptoWallet.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        cryptoWallet.balance,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),
                      )
                    ],
                  ),
                ),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
