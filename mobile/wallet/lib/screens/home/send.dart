import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet/logic.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:wallet/configuration_service.dart';
import 'package:wallet/tokenBalanceAPI.dart';

class SendCard extends StatefulWidget {
  final Token cryptoWallet;
  final Function handleCloseButton;
  final Function handleAdvancedButton;

  const SendCard(
      {Key? key,
      required this.cryptoWallet,
      required this.handleCloseButton,
      required this.handleAdvancedButton})
      : super(key: key);

  @override
  State<SendCard> createState() => _SendCardState();
}

class _SendCardState extends State<SendCard> {
  bool isAddressFocused = false;
  bool isAmountFocused = false;
  String _scanBarcode = 'Unknown';
  int selectedPriority = 1;

  late FocusNode addressFocusNode;
  late FocusNode amountFocusNode;
  late TextEditingController _addressTextController;
  late TextEditingController _amountTextController;

  @override
  void initState() {
    super.initState();
    setUpFocusNodes();
    _addressTextController = TextEditingController(text: "");
    _amountTextController = TextEditingController(text: "");
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
      height: 500,
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
                      "Send ${widget.cryptoWallet.symbol}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      color: Colors.white,
                      onPressed: () {
                        addressFocusNode.unfocus();
                        amountFocusNode.unfocus();
                        widget.handleCloseButton();
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
                  height: 15,
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
                    controller: _amountTextController,
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
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    widget.handleAdvancedButton();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Priority",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Row(
                        children: [
                          Text(
                            "Advanced",
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 16),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.blueAccent,
                            size: 16,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: Colors.blue.shade900.withOpacity(0.2), width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPriority = 0;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: selectedPriority == 0
                                  ? Colors.blueAccent
                                  : Colors.blue.shade900.withOpacity(0.2),
                            ),
                            child: Center(
                              child: Text(
                                "Low",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPriority = 1;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: selectedPriority == 1
                                  ? Colors.blueAccent
                                  : Colors.blue.shade900.withOpacity(0.2),
                            ),
                            child: Center(
                              child: Text(
                                "Medium",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPriority = 2;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: selectedPriority == 2
                                  ? Colors.blueAccent
                                  : Colors.blue.shade900.withOpacity(0.2),
                            ),
                            child: Center(
                              child: Text(
                                "High",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                onPressed: () async {
                  widget.handleCloseButton();
                  FocusManager.instance.primaryFocus?.unfocus();
                  showOverLay(context);
                  sendEth(
                      _addressTextController.text,
                      double.parse(_amountTextController.text),
                      0,
                      await estimateGas().then((value) =>
                          (value[selectedPriority].price).toDouble()));
                },
                child: Text("SEND"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void setUpFocusNodes() {
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
  }

  @override
  void dispose() {
    addressFocusNode.dispose();
    amountFocusNode.dispose();
    super.dispose();
  }

  void showOverLay(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context)!;
    OverlayEntry submittedEntry;
    OverlayEntry validatedEntry;

    submittedEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: MediaQuery.of(context).size.width * 0.05,
        bottom: MediaQuery.of(context).size.height * 0.02,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width * 0.90,
            color: Colors.grey[850],
            child: Material(
                color: Colors.transparent,
                child: Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Transaction submitted",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Waiting for validation",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      );
    });

    validatedEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: MediaQuery.of(context).size.width * 0.05,
        bottom: MediaQuery.of(context).size.height * 0.02,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width * 0.90,
            color: Colors.grey[850],
            child: Material(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Transaction complete!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      );
    });

    // Inserting the OverlayEntry into the Overlay
    overlayState.insert(submittedEntry);
    await Future.delayed(Duration(seconds: 3));
    submittedEntry.remove();

    overlayState.insert(validatedEntry);
    await Future.delayed(Duration(seconds: 1));
    validatedEntry.remove();
  }
}
