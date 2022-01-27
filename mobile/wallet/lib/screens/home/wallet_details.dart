import 'package:flutter/material.dart';
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
      backgroundColor: Colors.blueGrey[50],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: appBar(
          title: widget.cryptoWallet.name[0].toUpperCase() +
              widget.cryptoWallet.name.substring(1) +
              ' Wallet',
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.ac_unit_outlined,
                              color: Colors.black,
                              size: 35.0,
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                widget.cryptoWallet.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
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
                        child: InkWell(
                          onTap: () {
                            handleSendButton();
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: _actionButton(
                            text: 'Send',
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            handleReceiveButton();
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: _actionButton(
                            text: 'Receive',
                            color: Colors.pink,
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
            duration: Duration(milliseconds: 100),
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
            duration: Duration(milliseconds: 100),
            child: ReceiveCard(
              cryptoWallet: widget.cryptoWallet,
              handleReceiveButton: handleReceiveButton,
            ),
          ),
        ],
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
