import 'package:flutter/material.dart';
import 'package:wallet/screens/home/test_data.dart';
import 'package:wallet/screens/home/wallet_details.dart';
import 'package:wallet/screens/shared/shared.dart';

class WalletCard extends StatelessWidget {
  final CryptoWallet cryptoWallet;
  WalletCard(this.cryptoWallet);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => WalletDetails(cryptoWallet)),
        // );
      },
      // card(
      //   width: MediaQuery.of(context).size.width - 50,
      //   child:
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WalletDetails(cryptoWallet)),
          );
        },

        // TODO: The edged of the card are square and not round
        // TODO: probably has something to do with the positioning of Ink
        child: Ink(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
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
      ),
    );
  }
}
