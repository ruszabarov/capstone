import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallet/logic.dart';
import 'package:wallet/screens/home/account_card.dart';
import 'package:wallet/screens/home/add_token.dart';
import 'package:wallet/screens/home/add_wallet.dart';
import 'package:wallet/screens/home/firestore.dart';
import 'package:wallet/screens/shared/card.dart';
import 'package:web3dart/web3dart.dart';
import 'test_data.dart';
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
  List<CryptoWallet> currentWallets = mainAccount.wallets;
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
    updateValues();
  }

  void updateValues() async {
    for (int i = 0; i < mainAccount.wallets.length; i++) {
      mainAccount.wallets[i].balance = await getTokenBalance(
          EthereumAddress.fromHex(mainAccount.address), "ChainLink Token");
    }
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
                  child: new ListView.separated(
                    padding: EdgeInsets.all(25),
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 15,
                      );
                    },
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: accounts.length + 1,
                    itemBuilder: (BuildContext ctxt, int index) {
                      if (index == accounts.length) {
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
                            currentWallets = accounts[index].wallets;
                            accountSelectedIndex = index;
                          });
                        },
                        child: AccountCard(
                            accounts[index].name,
                            accounts[index].address,
                            accounts[index].balance,
                            accountSelectedIndex == index ? true : false),
                      );
                    },
                  ),
                ),
              ),
              Flexible(
                child: new ListView.separated(
                  padding: EdgeInsets.all(25),
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 15,
                    );
                  },
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: currentWallets.length + 1,
                  itemBuilder: (BuildContext ctxt, int index) {
                    if (index == currentWallets.length) {
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
                    return new WalletCard(currentWallets[index]);
                  },
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
        // AnimatedPositioned(
        //   left: 0,
        //   right: 0,
        //   bottom: isAddTokenVisible ? 0 : -450,
        //   height: 450,
        //   duration: Duration(milliseconds: 100),
        //   child: AddTokenCard(handleAddTokenButton),
        // ),
      ],
    );
  }
}
