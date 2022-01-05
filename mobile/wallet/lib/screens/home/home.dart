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

  void handleAddButton() {
    setState(() {
      isAddWalletVisible = !isAddWalletVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          child: Ink(
            color: Colors.grey[200],
            height: 193,
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
                  return Ink(
                    padding: EdgeInsets.all(15),
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
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
                  );
                }

                return new AccountCard(accounts[index].name,
                    accounts[index].address, accounts[index].balance);
              },
            ),
          ),
        ),
        // Material(
        //   child: Ink(
        //     color: Colors.grey[200],
        //     child: SingleChildScrollView(
        //       scrollDirection: Axis.horizontal,
        //       child: Padding(
        //         padding: const EdgeInsets.all(25),
        //         child: Row(
        //           children: [
        //             AccountCard(
        //                 "Main Account", "0x389537929832...", "\$2250.12"),
        //             SizedBox(
        //               width: 20,
        //             ),
        //             AccountCard(
        //                 "Second Account", "0x2378429832...", "\$1023.68"),
        //             SizedBox(
        //               width: 20,
        //             ),
        //             Ink(
        //               padding: EdgeInsets.all(15),
        //               width: 200,
        //               height: 150,
        //               decoration: BoxDecoration(
        //                   color: Colors.white,
        //                   borderRadius: BorderRadius.all(Radius.circular(15))),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text("Add Account"),
        //                   SizedBox(
        //                     height: 10,
        //                   ),
        //                   Icon(
        //                     Icons.add,
        //                     size: 70,
        //                   )
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
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
            itemCount: cryptoWallets.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return new WalletCard(cryptoWallets[index]);
            },
          ),
        ),
      ],
    );
  }
}
