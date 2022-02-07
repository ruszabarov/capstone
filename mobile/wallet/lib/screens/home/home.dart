import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/providers/Account.dart';
import 'package:wallet/screens/home/account_card.dart';
import 'package:wallet/screens/home/add_token.dart';
import 'package:wallet/screens/home/add_wallet.dart';
import 'package:wallet/screens/home/account_details_card.dart';
import 'package:wallet/screens/home/edit_account_card.dart';
import 'wallet_card.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isAddWalletVisible = false;
  bool isAccountDetailsVisible = false;
  bool isEditAccountVisible = false;
  int accountSelectedIndex = 0;

  void handleAddWalletButton() {
    setState(() {
      isAccountDetailsVisible = false;
      isEditAccountVisible = false;
      isAddWalletVisible = !isAddWalletVisible;
    });
  }

  void handleAccountDetailsButton() {
    setState(() {
      isAddWalletVisible = false;
      isEditAccountVisible = false;
      isAccountDetailsVisible = !isAccountDetailsVisible;
    });
  }

  void handleEditAccountButton() {
    setState(() {
      isAddWalletVisible = false;
      isAccountDetailsVisible = false;
      isEditAccountVisible = !isEditAccountVisible;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                child: Ink(
                  color: Colors.grey[200],
                  height: 210,
                  child: Consumer<AccountList>(
                    builder: (context, value, child) => PageView.builder(
                      itemCount: value.accounts.length,
                      controller: PageController(viewportFraction: 0.75),
                      onPageChanged: (int index) =>
                          setState(() => accountSelectedIndex = index),
                      itemBuilder: (_, i) {
                        return Transform.scale(
                          scale: i == accountSelectedIndex ? 1 : 0.9,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                handleAccountDetailsButton();
                              },
                              onLongPress: () {
                                handleEditAccountButton();
                              },
                              child: AccountCard(
                                value.accounts[i].name,
                                value.accounts[i].address,
                                value.accounts[i].balance,
                                value.accounts[i].colorPair,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Consumer<AccountList>(
                  builder: (context, value, child) => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    padding: EdgeInsets.all(25),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: value
                        .accounts[accountSelectedIndex].tokens.tokenList.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return new WalletCard(value.accounts[accountSelectedIndex]
                          .tokens.tokenList[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        AnimatedPositioned(
          left: 0,
          right: 0,
          bottom: isAddWalletVisible ? 0 : -300,
          height: 300,
          duration: Duration(milliseconds: 100),
          child: AddWalletCard(handleAddWalletButton),
        ),
        AnimatedPositioned(
          left: 0,
          right: 0,
          bottom: isAccountDetailsVisible ? 0 : -400,
          height: 400,
          duration: Duration(milliseconds: 100),
          child: Consumer<AccountList>(builder: (context, value, child) {
            return AccountDetailsCard(value.accounts[accountSelectedIndex],
                handleAccountDetailsButton);
          }),
        ),
        AnimatedPositioned(
          left: 0,
          right: 0,
          bottom: isEditAccountVisible ? 0 : -400,
          height: 400,
          duration: Duration(milliseconds: 100),
          child: Consumer<AccountList>(builder: (context, value, child) {
            return EditAccountCard(
                value.accounts[accountSelectedIndex], handleEditAccountButton);
          }),
        ),
      ],
    );
  }
}
