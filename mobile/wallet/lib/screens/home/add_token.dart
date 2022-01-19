import 'package:flutter/material.dart';
import 'package:wallet/screens/shared/shared.dart';

class AddTokenPage extends StatefulWidget {
  const AddTokenPage();

  @override
  State<AddTokenPage> createState() => _AddTokenPageState();
}

class _AddTokenPageState extends State<AddTokenPage> {
  bool isNameFocused = false;
  bool isAddressFocused = false;
  bool isDecimalsFocused = false;

  late FocusNode nameFocusNode;
  late FocusNode addressFocusNode;
  late FocusNode decimalsFocusNode;

  @override
  void initState() {
    nameFocusNode = FocusNode();
    addressFocusNode = FocusNode();
    decimalsFocusNode = FocusNode();

    nameFocusNode.addListener(() {
      setState(() {
        isNameFocused = nameFocusNode.hasFocus;
      });
    });

    addressFocusNode.addListener(() {
      setState(() {
        isAddressFocused = addressFocusNode.hasFocus;
      });
    });

    decimalsFocusNode.addListener(() {
      setState(() {
        isDecimalsFocused = decimalsFocusNode.hasFocus;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: appBar(
          title: 'Add Token',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Token name",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: isNameFocused
                      ? Colors.blueAccent
                      : Colors.black.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: TextField(
                focusNode: nameFocusNode,
                cursorColor: Colors.blueAccent,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Ethereum",
                  hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 16),
                  fillColor: Colors.blue,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Token address",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: isAddressFocused
                      ? Colors.blueAccent
                      : Colors.black.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: TextField(
                focusNode: addressFocusNode,
                cursorColor: Colors.blueAccent,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "0xC02aaA39b223FE8D0A...",
                  hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 16),
                  fillColor: Colors.blue,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Number of decimals",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: isDecimalsFocused
                      ? Colors.blueAccent
                      : Colors.black.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: TextField(
                focusNode: decimalsFocusNode,
                cursorColor: Colors.blueAccent,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "10",
                  hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 16),
                  fillColor: Colors.blue,
                ),
              ),
            ),
            SizedBox(
              height: 25,
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
                child: Text("ADD TOKEN"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
