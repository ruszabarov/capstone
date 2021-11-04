import 'package:flutter/material.dart';
import 'package:wallet/screens/home/test_data.dart';
import 'package:wallet/screens/shared/shared.dart';

class WalletCard extends StatelessWidget {
  final CryptoWallet cryptoWallet;
  WalletCard(this.cryptoWallet);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: card(
          width: MediaQuery.of(context).size.width - 50,
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
                      child: InkWell(
                        splashColor: Colors.red,
                        child: SizedBox(
                            width: 56,
                            height: 56,
                            child: Icon(
                              Icons.account_balance_wallet,
                              color: Colors.white,
                              size: 25.0,
                            )),
                        onTap: () {},
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text('Total Wallet Balance',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Row(
                    children: [Text('USD'), Icon(Icons.keyboard_arrow_down)],
                  )
                ],
              ),
            ],
          )),
    );
  }
}

/*
return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              SizedBox(width: 10),
              Icon(
                Icons.account_balance_wallet_outlined,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                cryptoWallet.name.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                cryptoWallet.balance.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WalletInfoPage(cryptoWallet)));
                },
                icon: Icon(Icons.arrow_right_rounded),
                iconSize: 50,
              ),
            ],
          )
        ],
      ),
    );
*/