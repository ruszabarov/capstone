import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/providers/Account.dart';
import 'package:wallet/screens/home/account_card.dart';
import 'package:wallet/screens/home/add_token.dart';
import 'package:wallet/screens/home/add_wallet.dart';
import 'wallet_card.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isAddWalletVisible = false;
  bool isAddTokenVisible = false;
  int accountSelectedIndex = 0;

  void handleAddWalletButton() {
    setState(() {
      isAddTokenVisible = false;
      isAddWalletVisible = !isAddWalletVisible;
    });
  }

  void handleAddTokenButton() {
    setState(() {
      isAddWalletVisible = false;
      isAddTokenVisible = !isAddTokenVisible;
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
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                child: Ink(
                  color: Colors.grey[200],
                  height: 210,
                  child: Consumer<AccountList>(
                    builder: (context, value, child) => ListView.separated(
                      padding: EdgeInsets.all(25),
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 15,
                        );
                      },
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: value.accounts.length + 1,
                      itemBuilder: (BuildContext ctxt, int index) {
                        if (index == value.accounts.length) {
                          return InkWell(
                            onTap: () {
                              handleAddWalletButton();
                            },
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: Ink(
                              padding: EdgeInsets.all(15),
                              width: 200,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Add Account"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 70,
                                  )
                                ],
                              ),
                            ),
                          );
                        }

                        return InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          onTap: () {
                            setState(() {
                              accountSelectedIndex = index;
                            });
                          },
                          child: AccountCard(
                              value.accounts[index].name,
                              value.accounts[index].address,
                              value.accounts[index].balance,
                              accountSelectedIndex == index ? true : false),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Consumer<AccountList>(
                  builder: (context, value, child) => ListView.separated(
                    padding: EdgeInsets.all(25),
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 15,
                      );
                    },
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: value.accounts[accountSelectedIndex].tokens
                            .tokenList.length +
                        1,
                    itemBuilder: (BuildContext ctxt, int index) {
                      if (index ==
                          value.accounts[accountSelectedIndex].tokens.tokenList
                              .length) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: InkWell(
                              onTap: () {
                                // handleAddTokenButton();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddTokenPage(),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(25),
                              child: Ink(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.blueAccent,
                                ),
                                child: Center(
                                  child: Text(
                                    "Add Token",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
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
      ],
    );
  }
}
