import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:wallet/logic.dart';
import 'package:wallet/providers/Market.dart';
import 'package:wallet/screens/home/wallet_details.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:web3dart/web3dart.dart';
import 'package:wallet/configuration_service.dart';

class WalletCard extends StatefulWidget {
  final Token token;
  final int accountId;
  final Account account;
  WalletCard(this.token, this.accountId, this.account);

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
    if (widget.token.symbol == 'ETH') {
      double ethBalance =
          await double.parse(await getEthBalance(widget.account.publicKey));

      setState(() {
        balance = ethBalance;
      });
    } else {
      double tokenBalance = await double.parse(await getTokenBalance(
          widget.account.publicKey, widget.token.address));

      setState(() {
        balance = tokenBalance;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                WalletDetailsPage(widget.token, widget.account),
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
              "${balance} ${widget.token.symbol}",
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
                    value.markets[widget.token.name] != null
                        ? "\$${(value.markets[widget.token.name]!.currentPrice).toStringAsFixed(0)}"
                        : "unknown",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    value.markets[widget.token.name] != null
                        ? "${(value.markets[widget.token.name]!.priceChangePercent).toStringAsFixed(1)}%"
                        : "",
                    style: TextStyle(
                      color: value.markets[widget.token.name] != null
                          ? value.markets[widget.token.name]!
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
