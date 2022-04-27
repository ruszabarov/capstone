import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet/configuration_service.dart';
import 'package:wallet/providers/Account.dart';
import 'package:wallet/providers/Token.dart';
import 'package:wallet/screens/home/mnemonic_page.dart';
import 'package:wallet/screens/shared/neumorphic_card.dart';
import 'package:wallet/wallet_setup.dart';

class AddAccountPage extends StatefulWidget {
  final int accountId;
  const AddAccountPage(this.accountId);

  @override
  _AddAccountPageState createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  bool addAccount = false;
  late TextEditingController nameController;
  late TextEditingController keyController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    keyController = TextEditingController();
  }

  void handleButton(String value) {
    if (value != '') {
      setState(() {
        addAccount = true;
      });
    } else {
      setState(() {
        addAccount = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Nickname (required)"),
        SizedBox(
          height: 10,
        ),
        Neumorphic(
          style: NeumorphicStyle(
            color: Colors.grey[200],
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
            depth: -4,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: nameController,
              style: TextStyle(
                decoration: TextDecoration.none,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter Name",
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text("Private key (optional)"),
        SizedBox(
          height: 10,
        ),
        Neumorphic(
          style: NeumorphicStyle(
            color: Colors.grey[200],
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
            depth: -4,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              onChanged: handleButton,
              controller: keyController,
              style: TextStyle(
                decoration: TextDecoration.none,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter Key",
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Consumer<AccountList>(
                builder: (context, value, child) {
                  return NeumorphicCard(
                    Center(
                      child: addAccount
                          ? Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "IMPORT ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: "ACCOUNT",
                                  ),
                                ],
                              ),
                            )
                          : Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "CREATE ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: "ACCOUNT",
                                  ),
                                ],
                              ),
                            ),
                    ),
                    () async {
                      if (!addAccount) {
                        ConfigurationService configurationService =
                            ConfigurationService(
                                await SharedPreferences.getInstance());

                        await configurationService
                            .addAccount(nameController.text);

                        await configurationService.addEther(widget.accountId);

                        context.read<AccountList>().loadAccounts();
                        context.read<TokenList>().loadTokens();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
