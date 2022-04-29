import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet/providers/Account.dart';
import 'package:wallet/providers/Market.dart';
import 'package:wallet/providers/Navbar.dart';
import 'package:wallet/providers/Token.dart';
import 'package:wallet/screens/account/settings.dart';
import 'package:wallet/screens/market/market.dart';
import 'package:wallet/screens/shared/appBar.dart';
import 'package:wallet/wallet_icons.dart';
import 'package:wallet/screens/home/home.dart';
import 'package:wallet/configuration_service.dart';

class Wrapper extends StatefulWidget {
  final List<Account> initAccountData;
  final Map<String, Market> initMarketData;

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
  bool isNavVisible = true;
  late PageController _pageController;
  late Widget home;
  late Widget market;
  late Widget account;

  List<String> titles = ["Wallets", "Market", "Account"];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    home = Home();
    market = MarketPage();
    account = SettingsPage();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Navbar(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(80),
        //   child: appBar(
        //     title: "$_currentTitle",
        //   ),
        // ),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider<MarketList>(
              create: (context) => MarketList(widget.initMarketData),
            ),
          ],
          child: SafeArea(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: <Widget>[
                home,
                market,
                account,
              ],
            ),
          ),
        ),
        bottomNavigationBar: Consumer<Navbar>(
          builder: (context, value, child) => AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            height: value.isVisible ? 55 : 0,
            child: Wrap(
              children: [
                BottomNavigationBar(
                  backgroundColor: Colors.grey[200],
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
              ],
            ),
          ),
        ),
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
