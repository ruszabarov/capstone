import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/screens/home/test_data.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
  bool isAddressFocused = false;
  bool isAmountFocused = false;
  String _scanBarcode = 'Unknown';

  late FocusNode addressFocusNode;
  late FocusNode amountFocusNode;
  late TextEditingController _addressTextController;

  @override
  void initState() {
    addressFocusNode = FocusNode();
    amountFocusNode = FocusNode();

    addressFocusNode.addListener(() {
      setState(() {
        isAddressFocused = addressFocusNode.hasFocus;
      });
    });

    amountFocusNode.addListener(() {
      setState(() {
        isAmountFocused = amountFocusNode.hasFocus;
      });
    });

    super.initState();
    _addressTextController = TextEditingController(text: "");
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      setState(() {
        _addressTextController.text = barcodeScanRes;
      });
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
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
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: isAddressFocused
                            ? Colors.blueAccent
                            : Colors.blue.shade900.withOpacity(0.2),
                        width: 2),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: TextField(
                          controller: _addressTextController,
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
                      Material(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(3),
                          bottomRight: Radius.circular(3),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(3),
                              bottomRight: Radius.circular(3),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              scanQR();
                            },
                            icon: Icon(
                              Icons.qr_code,
                              color: Colors.white,
                            ),
                          ),
                        ),
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: isAmountFocused
                            ? Colors.blueAccent
                            : Colors.blue.shade900.withOpacity(0.2),
                        width: 2),
                  ),
                  child: TextField(
                    focusNode: amountFocusNode,
                    cursorColor: Colors.blueAccent,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Amount",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                      fillColor: Colors.blue,
                    ),
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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('Transaction successful'),
                      content: Text(
                          'Please wait for the next block on the blockchain.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'OK');
                          },
                          child: Text("OK"),
                        )
                      ],
                    ),
                  );
                },
                child: Text("GENERATE OTP"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
