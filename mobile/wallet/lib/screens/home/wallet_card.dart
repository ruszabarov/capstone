import 'package:flutter/material.dart';
import 'package:wallet/logic.dart';
import 'package:wallet/providers/Token.dart';
import 'package:wallet/screens/home/wallet_details.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:web3dart/web3dart.dart';

class WalletCard extends StatefulWidget {
  final Token cryptoWallet;
  WalletCard(this.cryptoWallet);

  @override
  State<WalletCard> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WalletDetailsPage(widget.cryptoWallet)),
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
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset(widget.cryptoWallet.iconURL),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cryptoWallet.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.cryptoWallet.balance.toString(),
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
