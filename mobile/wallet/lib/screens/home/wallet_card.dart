import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:wallet/logic.dart';
import 'package:wallet/providers/Market.dart';
import 'package:wallet/providers/Token.dart';
import 'package:wallet/screens/home/wallet_details.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:web3dart/web3dart.dart';
import 'package:wallet/configuration_service.dart';

class WalletCard extends StatefulWidget {
  final Token cryptoWallet;
  WalletCard(this.cryptoWallet);

  @override
  State<WalletCard> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  double balance = 0;

  @override
  void initState() {
    super.initState();
    getBalance();
  }

  void getBalance() async {
    await getEthBalance(widget.cryptoWallet.address);
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WalletDetailsPage(widget.cryptoWallet),
          ),
        );
      },
      duration: Duration(milliseconds: 100),
      style: NeumorphicStyle(
        color: Colors.grey[200],
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
        depth: 8,
      ),
      padding: const EdgeInsets.all(3),
      child: card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipOval(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset("assets/images/coin_logos/ethereum.webp"),
                ),
              ),
            ),
            Spacer(),
            Text(
              "${balance} ${widget.cryptoWallet.symbol}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Consumer<MarketList>(
              builder: (context, value, child) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value.markets[widget.cryptoWallet.name] != null
                        ? "\$${(value.markets[widget.cryptoWallet.name]!.currentPrice).toStringAsFixed(0)}"
                        : "unkown",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    value.markets[widget.cryptoWallet.name] != null
                        ? "${(value.markets[widget.cryptoWallet.name]!.priceChangePercent).toStringAsFixed(1)}%"
                        : "",
                    style: TextStyle(
                      color: value.markets[widget.cryptoWallet.name] != null
                          ? value.markets[widget.cryptoWallet.name]!
                                      .priceChangePercent >
                                  0
                              ? Colors.green
                              : Colors.red
                          : Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
