import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet/configuration_service.dart';
import 'package:wallet/providers/Account.dart';

class EditAccountCard extends StatefulWidget {
  final Account account;
  final int accountId;
  final Function handleCloseButton;

  const EditAccountCard(this.account, this.handleCloseButton, this.accountId);

  @override
  State<EditAccountCard> createState() => _EditAccountCardState();
}

class _EditAccountCardState extends State<EditAccountCard> {
  late FocusNode nameFocusNode;
  late TextEditingController nameTextController;
  bool isNameFocused = false;

  @override
  void initState() {
    super.initState();
    setUpFocusNodes();
    nameTextController = TextEditingController(text: "");
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Edit account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                  ),
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
              "Account Name",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: isNameFocused
                              ? Colors.blueAccent
                              : Colors.blue.shade900.withOpacity(0.2),
                          width: 2),
                    ),
                    child: TextField(
                      controller: nameTextController,
                      focusNode: nameFocusNode,
                      cursorColor: Colors.blueAccent,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "${widget.account.name}",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                        fillColor: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 35,
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
                  FocusManager.instance.primaryFocus?.unfocus();
                  // AccountList accountList = context.read<AccountList>();
                  // accountList.editName(nameTextController.text);
                  nameTextController.text = "";
                  widget.handleCloseButton();
                },
                child: Text("SAVE"),
              ),
            ),
            Spacer(),
            Container(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                onPressed: () async {
                  ConfigurationService configurationService =
                      ConfigurationService(
                          await SharedPreferences.getInstance());

                  configurationService.removeAccount(widget.accountId);
                },
                child: Text("DELETE ACCOUNT"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void setUpFocusNodes() {
    nameFocusNode = FocusNode();

    nameFocusNode.addListener(() {
      setState(() {
        isNameFocused = nameFocusNode.hasFocus;
      });
    });
  }
}
