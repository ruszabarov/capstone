import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/providers/Account.dart';
import 'package:wallet/providers/Market.dart';
import 'package:wallet/screens/account/account.dart';
import 'package:wallet/screens/home/add_wallet.dart';
import 'package:wallet/screens/market/market.dart';
import 'package:wallet/screens/shared/appBar.dart';
import 'package:wallet/wallet_icons.dart';
import 'package:wallet/screens/home/home.dart';

class Wrapper extends StatefulWidget {
  final List<Account> initAccountData;
  final List<Market> initMarketData;

  Wrapper(this.initAccountData, this.initMarketData);

  @override
  State createState() {
    return _WrapperState();
  }
}

enum TabItem { home, market, account }

class _WrapperState extends State<Wrapper> {
  int _selectedIndex = 0;
  String _currentTitle = "Wallets";
  late PageController _pageController;
  late Widget home;
  late Widget market;
  late Widget account;

  List<String> titles = ["Wallets", "Market", "Account"];

  @override
  void initState() {
    _pageController = PageController();
    home = Home();
    market = MarketPage();
    account = AccountPage();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: appBar(
          title: "$_currentTitle",
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: <Widget>[
          MultiProvider(
            providers: [
              ChangeNotifierProvider<AccountList>(
                create: (context) => AccountList(widget.initAccountData),
              ),
            ],
            child: home,
          ),
          MultiProvider(providers: [
            ChangeNotifierProvider<MarketList>(
              create: (context) => MarketList(widget.initMarketData),
            ),
          ], child: market),
          account,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_rounded),
            label: 'Wallets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Wallet.chart_line),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Wallet.user),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _currentTitle = titles[index];
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }
}
