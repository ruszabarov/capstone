import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/logic.dart';
import 'package:wallet/providers/Market.dart';
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
      child: Consumer<MarketList>(
        builder: (context, value, child) => card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipOval(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset(widget.cryptoWallet.iconURL),
                  ),
                ),
              ),
              Spacer(),
              Text(
                "${widget.cryptoWallet.balance} ${widget.cryptoWallet.shortName}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${(widget.cryptoWallet.balance * value.markets[widget.cryptoWallet.name]!.currentPrice).toStringAsFixed(1)}",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${(value.markets[widget.cryptoWallet.name]!.priceChangePercent).toStringAsFixed(1)}%",
                    style: TextStyle(
                      color: value.markets[widget.cryptoWallet.name]!
                                  .priceChangePercent >
                              0
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
