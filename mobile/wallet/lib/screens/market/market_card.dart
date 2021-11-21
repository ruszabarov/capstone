import 'package:flutter/material.dart';
import 'package:wallet/screens/home/test_data.dart';
import 'package:wallet/screens/home/wallet_details.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:wallet/wallet_icons.dart';

class MarketCard extends StatelessWidget {
  final String marketName;
  final String price = '\$100';
  MarketCard(this.marketName);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => WalletDetailsPage(cryptoWallet)
        //       ),
        // );
      },
      borderRadius: BorderRadius.circular(15),
      child: card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Material(
                        color: Colors.black87,
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Wallet.ethereum,
                            color: Colors.white,
                            size: 25.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          marketName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          price,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.keyboard_arrow_right),
              ],
            )
          ],
        ),
      ),
    );
  }
}
