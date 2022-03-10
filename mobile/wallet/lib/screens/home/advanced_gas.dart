import 'package:flutter/material.dart';

class AdvancedGas extends StatefulWidget {
  final Function handleCloseButton;

  const AdvancedGas(this.handleCloseButton);

  @override
  State<AdvancedGas> createState() => _AdvancedGasState();
}

class _AdvancedGasState extends State<AdvancedGas> {
  bool isGasLimitFocused = false;
  bool isMaxPriorityFeeFocused = false;
  bool isMaxFeeFocused = false;

  late FocusNode gasLimitFocusNode;
  late FocusNode maxPriorityFeeFocusNode;
  late FocusNode maxFeeFocusNode;

  late TextEditingController _gasLimitTextController;
  late TextEditingController _maxPriorityFeeController;
  late TextEditingController _maxFeeController;

  @override
  void initState() {
    super.initState();
    setUpFocusNodes();
  }

  void setUpFocusNodes() {
    _gasLimitTextController = TextEditingController(text: "");
    _maxPriorityFeeController = TextEditingController(text: "");
    _maxFeeController = TextEditingController(text: "");

    gasLimitFocusNode = FocusNode();
    maxPriorityFeeFocusNode = FocusNode();
    maxFeeFocusNode = FocusNode();

    gasLimitFocusNode.addListener(() {
      setState(() {
        isGasLimitFocused = gasLimitFocusNode.hasFocus;
      });
    });

    maxPriorityFeeFocusNode.addListener(() {
      setState(() {
        isMaxPriorityFeeFocused = maxPriorityFeeFocusNode.hasFocus;
      });
    });

    maxFeeFocusNode.addListener(() {
      setState(() {
        isMaxFeeFocused = maxFeeFocusNode.hasFocus;
      });
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
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Advanced Gas Fees",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () {
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
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.blue.shade900.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: isGasLimitFocused
                        ? Colors.blueAccent
                        : Colors.blue.shade900.withOpacity(0.2),
                    width: 2),
              ),
              child: TextField(
                controller: _gasLimitTextController,
                focusNode: gasLimitFocusNode,
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
      ),
    );
  }
}
