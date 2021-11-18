import 'package:flutter/material.dart';
import 'package:wallet/screens/home/test_data.dart';
import 'package:wallet/screens/shared/shared.dart';

class SendCard extends StatefulWidget {
  final CryptoWallet cryptoWallet;
  final Function handleSendButton;

  const SendCard(
      {Key? key,
      required this.cryptoWallet,
      required Function this.handleSendButton})
      : super(key: key);

  @override
  State<SendCard> createState() => _SendCardState();
}

class _SendCardState extends State<SendCard> {
  bool isAddressFocued = false;
  void handleAdressFocus() {
    setState(() {
      isAddressFocued = !isAddressFocued;
    });
  }

  late FocusNode addressFocusNode;

  @override
  void initState() {
    addressFocusNode = FocusNode();
    addressFocusNode.addListener(() {
      setState(() {
        isAddressFocued = addressFocusNode.hasFocus;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Send ${widget.cryptoWallet.shortName}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      color: Colors.white,
                      onPressed: () {
                        widget.handleSendButton();
                      },
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    )
                  ],
                ),
                Divider(
                  thickness: 3,
                  height: 40,
                  color: Colors.white,
                ),
                Text(
                  "Receiver's Address",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: isAddressFocued
                            ? Colors.blueAccent
                            : Colors.blue.shade900.withOpacity(0.2),
                        width: 2),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextField(
                          focusNode: addressFocusNode,
                          cursorColor: Colors.blueAccent,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Address",
                            hintStyle:
                                TextStyle(color: Colors.white, fontSize: 16),
                            fillColor: Colors.blue,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.qr_code,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Amount",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  cursorColor: Colors.blueAccent,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    hintText: "Enter Amount",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    fillColor: Colors.blue,
                  ),
                ),
              ],
            ),
            Container(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Text("GENERATE OTP"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
