import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet/providers/Account.dart';
import 'package:wallet/providers/Navbar.dart';
import 'package:wallet/configuration_service.dart';
import 'package:wallet/providers/Token.dart';
import 'package:wallet/screens/home/account_card.dart';
import 'package:wallet/screens/home/add_account_card.dart';
import 'package:wallet/screens/home/add_account_page.dart';
import 'package:wallet/screens/home/add_token.dart';
import 'package:wallet/screens/home/account_details_card.dart';
import 'package:wallet/screens/home/edit_account_card.dart';
import 'package:wallet/screens/shared/neumorphic_card.dart';
import 'wallet_card.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAddWalletVisible = false;
  bool isAccountDetailsVisible = false;
  bool isEditAccountVisible = false;
  int accountSelectedIndex = 0;

  int selectedInterval = 1;

  void handleAccountDetailsButton() {
    setState(() {
      isEditAccountVisible = false;
      isAccountDetailsVisible = !isAccountDetailsVisible;
    });

    handleNavBar();
  }

  void handleEditAccountButton() {
    setState(() {
      isAccountDetailsVisible = false;
      isEditAccountVisible = !isEditAccountVisible;
    });

    handleNavBar();
  }

  void handleNavBar() {
    if (!isAccountDetailsVisible && !isEditAccountVisible) {
      context.read<Navbar>().show();
    } else {
      context.read<Navbar>().hide();
    }
  }

  // List<Token> tokenList = [];

  @override
  void initState() {
    super.initState();
    print("hello");
    context.read<TokenList>().loadTokens();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: Text(
                  "Your Wallets",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Material(
                child: Ink(
                  color: Colors.grey[200],
                  height: 230,
                  child: Consumer<AccountList>(
                    builder: (context, value, child) => PageView.builder(
                      itemCount: value.accounts.length + 1,
                      controller: PageController(viewportFraction: 0.8),
                      onPageChanged: (int index) =>
                          setState(() => accountSelectedIndex = index),
                      itemBuilder: (_, i) {
                        return Transform.scale(
                          scale: i == accountSelectedIndex ? 1.1 : 0.9,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 25),
                            child: i != value.accounts.length
                                ? InkWell(
                                    borderRadius: BorderRadius.circular(15),
                                    onTap: () {
                                      handleAccountDetailsButton();
                                    },
                                    onLongPress: () {
                                      handleEditAccountButton();
                                    },
                                    child: AccountCard(
                                      name: value.accounts[i].name,
                                      address: value.accounts[i].publicKey,
                                      colorPair: colorPairs[i],
                                      key: UniqueKey(),
                                    ),
                                  )
                                : AddAccountCard(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Consumer<AccountList>(
                  builder: (context, value, child) => accountSelectedIndex !=
                          value.accounts.length
                      ? Column(
                          children: [
                            Consumer<TokenList>(
                              builder: (context, tokenList, child) => tokenList
                                          .tokens.length !=
                                      0
                                  ? GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 25,
                                              mainAxisSpacing: 25),
                                      padding: EdgeInsets.all(25),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      //! load tokens in load_data to avoid error
                                      itemCount: tokenList
                                          .tokens[accountSelectedIndex].length,
                                      itemBuilder:
                                          (BuildContext ctxt, int index) {
                                        return WalletCard(
                                          token: tokenList
                                                  .tokens[accountSelectedIndex]
                                              [index],
                                          accountId: accountSelectedIndex,
                                          account: value
                                              .accounts[accountSelectedIndex],
                                          key: UniqueKey(),
                                        );
                                      },
                                    )
                                  : CircularProgressIndicator(),
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AddTokenPage(accountSelectedIndex),
                                    ),
                                  );
                                },
                                child: Text("Add Token"),
                              ),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AddAccountPage(value.accounts.length),
                        ),
                ),
              ),
            ],
          ),
        ),
        AnimatedPositioned(
          left: 0,
          right: 0,
          bottom: isAccountDetailsVisible ? 0 : -401,
          height: 400,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: Consumer<AccountList>(
            builder: (context, value, child) {
              if (accountSelectedIndex != value.accounts.length) {
                return AccountDetailsCard(value.accounts[accountSelectedIndex],
                    handleAccountDetailsButton);
              }
              return Container();
            },
          ),
        ),
        AnimatedPositioned(
          left: 0,
          right: 0,
          bottom: isEditAccountVisible ? 0 : -401,
          height: 400,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: Consumer<AccountList>(
            builder: (context, value, child) {
              if (accountSelectedIndex != value.accounts.length) {
                return EditAccountCard(value.accounts[accountSelectedIndex],
                    handleEditAccountButton, accountSelectedIndex);
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
