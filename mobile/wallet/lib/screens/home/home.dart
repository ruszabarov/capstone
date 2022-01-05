import 'package:flutter/material.dart';
import 'package:wallet/screens/home/account_card.dart';
import 'package:wallet/screens/home/add_wallet.dart';
import 'package:wallet/screens/shared/card.dart';
import 'test_data.dart';
import 'wallet_card.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAddWalletVisible = false;
  List<CryptoWallet> currentWallets = mainAccount.wallets;
  int accountSelectedIndex = 0;

  void handleAddButton() {
    setState(() {
      isAddWalletVisible = !isAddWalletVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
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
                          handleAddButton();
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
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: currentWallets.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return new WalletCard(currentWallets[index]);
                },
              ),
            ),
          ],
        ),
        AnimatedPositioned(
          left: 0,
          right: 0,
          bottom: isAddWalletVisible ? 0 : -300,
          height: 300,
          duration: Duration(milliseconds: 100),
          child: AddWalletCard(handleAddButton),
        ),
      ],
    );
  }
}
