import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:wallet/providers/Token.dart';
import 'package:wallet/screens/home/receive.dart';
import 'package:wallet/screens/home/send.dart';
import 'package:wallet/screens/home/test_data.dart';
import 'package:wallet/screens/home/transaction_list.dart';
import 'package:wallet/screens/shared/shared.dart';

class WalletDetailsPage extends StatefulWidget {
  final Token cryptoWallet;

  WalletDetailsPage(this.cryptoWallet);

  @override
  State<WalletDetailsPage> createState() => _WalletDetailsPageState();
}

class _WalletDetailsPageState extends State<WalletDetailsPage> {
  bool isSendVisible = false;
  bool isReceiveVisible = false;

  void handleSendButton() {
    setState(() {
      isReceiveVisible = false;
      isSendVisible = !isSendVisible;
    });
  }

  void handleReceiveButton() {
    setState(() {
      isSendVisible = false;
      isReceiveVisible = !isReceiveVisible;
    });
  }

  void handleReceiptButton() {
    Navigator.pop(context);
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
                            width: 15,
                          ),
                          Text(
                            widget.cryptoWallet.name,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
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
                                  child:
                                      Image.asset(widget.cryptoWallet.iconURL),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  widget.cryptoWallet.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              // Text('$cryptoShort')
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            "${widget.cryptoWallet.balance} ${widget.cryptoWallet.shortName}",
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
                      child: TransactionList(transactions, handleReceiptButton),
                    ),
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
              bottom: isSendVisible ? 0 : -400,
              height: 400,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              child: SendCard(
                cryptoWallet: widget.cryptoWallet,
                handleCloseButton: handleSendButton,
              ),
            ),
            AnimatedPositioned(
              left: 0,
              right: 0,
              bottom: isReceiveVisible ? 0 : -400,
              height: 400,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              child: ReceiveCard(
                cryptoWallet: widget.cryptoWallet,
                handleReceiveButton: handleReceiveButton,
              ),
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
