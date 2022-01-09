import 'package:flutter/material.dart';

class AddTokenCard extends StatefulWidget {
  final Function handleFunction;
  const AddTokenCard(this.handleFunction);

  @override
  State<AddTokenCard> createState() => _AddTokenCardState();
}

class _AddTokenCardState extends State<AddTokenCard> {
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
    return Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add token",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () {
                    widget.handleFunction();
                  },
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                )
              ],
            ),
            Divider(
              thickness: 3,
              height: 30,
              color: Colors.white,
            ),
            Text(
              "Token name",
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
                  color: isNameFocused
                      ? Colors.blueAccent
                      : Colors.blue.shade900.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: TextField(
                focusNode: nameFocusNode,
                cursorColor: Colors.blueAccent,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Ethereum",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                  fillColor: Colors.blue,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Token address",
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
                  color: isAddressFocused
                      ? Colors.blueAccent
                      : Colors.blue.shade900.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: TextField(
                focusNode: addressFocusNode,
                cursorColor: Colors.blueAccent,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "0xC02aaA39b223FE8D0A...",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                  fillColor: Colors.blue,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Number of decimals",
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
                  color: isDecimalsFocused
                      ? Colors.blueAccent
                      : Colors.blue.shade900.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: TextField(
                focusNode: decimalsFocusNode,
                cursorColor: Colors.blueAccent,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "10",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 16),
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
