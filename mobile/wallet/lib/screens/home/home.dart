import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/providers/Account.dart';
import 'package:wallet/screens/home/account_card.dart';
import 'package:wallet/screens/home/add_token.dart';
import 'package:wallet/screens/home/add_wallet.dart';
import 'wallet_card.dart';
import 'account_card_painter.dart';

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
          // physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                child: Ink(
                  color: Colors.grey[300],
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
                            child: Container(
                              child: CustomPaint(
                                size: Size.fromHeight(175),
                                painter: AccountCardPainter(),
                              ),
                            ),
                            //     AccountCard(
                            //   value.accounts[i].name,
                            //   value.accounts[i].address,
                            //   value.accounts[i].balance,
                            // ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Divider(
              //   thickness: 5,
              //   color: Colors.grey,
              //   height: 5,
              // ),
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


                    // ListView.separated(
                    //   padding: EdgeInsets.all(25),
                    //   separatorBuilder: (BuildContext context, int index) {
                    //     return SizedBox(
                    //       width: 15,
                    //     );
                    //   },
                    //   physics: BouncingScrollPhysics(),
                    //   scrollDirection: Axis.horizontal,
                    //   itemCount: value.accounts.length + 4,
                    //   itemBuilder: (BuildContext ctxt, int index) {
                        // if (index == value.accounts.length) {
                        //   return InkWell(
                        //     onTap: () {
                        //       handleAddWalletButton();
                        //     },
                        //     borderRadius: BorderRadius.all(Radius.circular(15)),
                        //     child: Ink(
                        //       padding: EdgeInsets.all(15),
                        //       width: MediaQuery.of(context).size.width * 0.7,
                        //       height: 150,
                        //       decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(15))),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text("Add Account"),
                        //           SizedBox(
                        //             height: 10,
                        //           ),
                        //           Icon(
                        //             Icons.add,
                        //             size: 70,
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   );
                        // }
                        // return InkWell(
                        //   borderRadius: BorderRadius.all(Radius.circular(15)),
                        //   onTap: () {
                        //     setState(() {
                        //       accountSelectedIndex = index;
                        //     });
                        //   },
                        //   child: AccountCard(
                        //       value.accounts[0].name,
                        //       value.accounts[0].address,
                        //       value.accounts[0].balance,
                        //       accountSelectedIndex == index ? true : false),
                        // );
              //         },
