import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet/logic.dart';
import 'package:wallet/providers/Token.dart';
import 'package:wallet/screens/home/advanced_gas.dart';
import 'package:wallet/screens/home/receive.dart';
import 'package:wallet/screens/home/send.dart';
import 'package:wallet/screens/home/test_data.dart';
import 'package:wallet/screens/home/transaction_list.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:wallet/configuration_service.dart';
import 'package:provider/provider.dart';
import 'package:wallet/tokenBalanceAPI.dart';

class WalletDetailsPage extends StatefulWidget {
  final Token token;
  final Account account;

  WalletDetailsPage(this.token, this.account);

  @override
  State<WalletDetailsPage> createState() => _WalletDetailsPageState();
}

class _WalletDetailsPageState extends State<WalletDetailsPage> {
  bool isSendVisible = false;
  bool isReceiveVisible = false;
  bool isAdvancedVisible = false;
  List<dynamic> transactions = [];
  double balance = 0;

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

  void handleSendButton() {
    setState(() {
      isReceiveVisible = false;
      isAdvancedVisible = false;
      isSendVisible = !isSendVisible;
    });
  }

  void handleReceiveButton() {
    setState(() {
      isSendVisible = false;
      isAdvancedVisible = false;
      isReceiveVisible = !isReceiveVisible;
    });
  }

  void handleAdvancedButton() {
    if (isAdvancedVisible) {
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() {
        isReceiveVisible = false;
        isAdvancedVisible = false;
        isSendVisible = true;
      });
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() {
        isReceiveVisible = false;
        isAdvancedVisible = true;
        isSendVisible = false;
      });
    }
  }

  void handleReceiptButton() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    loadTransactionHistory();
    getBalance();
  }

  void loadTransactionHistory() async {
    if (widget.token.name == "Ether") {
      transactions = await ethTxHistory(widget.account.publicKey);
      setState(() {});
    } else {
      transactions =
          await tokenTxHistory(widget.account.publicKey, widget.token.address);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.grey[200],
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(15)),
                              depth: 4,
                            ),
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.token.name,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.grey[200],
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(15)),
                              depth: 4,
                            ),
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.delete,
                              color: Colors.red.shade400,
                            ),
                            onPressed: () async {
                              ConfigurationService configurationService =
                                  context.read<ConfigurationService>();

                              await configurationService
                                  .removeToken(widget.token.address);

                              context.read<TokenList>().loadTokens();
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Neumorphic(
                      style: NeumorphicStyle(
                        color: Colors.grey[200],
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(15)),
                        depth: 8,
                      ),
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.all(20),
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
                                  child: Image.asset(
                                      "assets/images/coin_logos/ethereum.webp"),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "${balance} ${widget.token.symbol}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.black87),
                              ),
                              // Text('$cryptoShort')
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: NeumorphicButton(
                            onPressed: () {
                              handleSendButton();
                            },
                            duration: Duration(milliseconds: 100),
                            style: NeumorphicStyle(
                              color: Colors.grey[200],
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(15)),
                              depth: isSendVisible ? -4 : 8,
                            ),
                            padding: const EdgeInsets.all(3),
                            child: _actionButton(
                              text: 'Send',
                              color: Colors.red.shade400,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: NeumorphicButton(
                            onPressed: () {
                              handleReceiveButton();
                            },
                            duration: Duration(milliseconds: 100),
                            style: NeumorphicStyle(
                              color: Colors.grey[200],
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(15)),
                              depth: isReceiveVisible ? -4 : 8,
                            ),
                            padding: const EdgeInsets.all(3),
                            child: _actionButton(
                              text: 'Receive',
                              color: Colors.green.shade400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.history),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Transaction History",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Flexible(
                        child: transactions.isNotEmpty
                            ? TransactionList(transactions, handleReceiptButton,
                                widget.account.publicKey, widget.token)
                            : CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            AnimatedPositioned(
              left: 0,
              right: 0,
              bottom: isSendVisible ? 0 : -500,
              height: 500,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              child: SendCard(
                cryptoWallet: widget.token,
                handleCloseButton: handleSendButton,
                handleAdvancedButton: handleAdvancedButton,
              ),
            ),
            AnimatedPositioned(
              left: 0,
              right: 0,
              bottom: isReceiveVisible ? 0 : -400,
              height: 400,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              child: ReceiveCard(
                cryptoWallet: widget.token,
                address: widget.account.publicKey,
                handleReceiveButton: handleReceiveButton,
              ),
            ),
            AnimatedPositioned(
              left: 0,
              right: 0,
              bottom: isAdvancedVisible ? 0 : -500,
              height: 500,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              child: AdvancedGas(handleAdvancedButton),
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
              child: SizedBox(
                width: 56,
                height: 56,
                child: Icon(
                  Icons.attach_money,
                  color: Colors.white,
                  size: 25.0,
                ),
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
