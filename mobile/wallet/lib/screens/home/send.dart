import 'package:flutter/material.dart';
import 'package:wallet/screens/home/test_data.dart';
import 'package:wallet/screens/shared/shared.dart';

class SendCard extends StatelessWidget {
  final CryptoWallet cryptoWallet;
  final Function handleSendButton;

  const SendCard(
      {Key? key,
      required this.cryptoWallet,
      required Function this.handleSendButton})
      : super(key: key);

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
                      "Send ${cryptoWallet.shortName}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      color: Colors.white,
                      onPressed: () {
                        handleSendButton();
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
                    hintText: "Enter Address",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    fillColor: Colors.blue,
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
