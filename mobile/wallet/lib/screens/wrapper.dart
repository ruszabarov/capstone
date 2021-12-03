import 'package:flutter/material.dart';
import 'package:wallet/screens/account/account.dart';
import 'package:wallet/screens/market/market.dart';
import 'package:wallet/screens/shared/appBar.dart';
import 'package:wallet/wallet_icons.dart';
import 'package:wallet/screens/home/home.dart';

class Wrapper extends StatefulWidget {
  @override
  State createState() {
    return _WrapperState();
  }
}

enum TabItem { home, market, account }

class _WrapperState extends State {
  TabItem _currentItem = TabItem.home;

  final List<TabItem> _bottomTabs = [
    TabItem.home,
    TabItem.market,
    TabItem.account,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: appBar(
          title: _setTitle(_currentItem),
        ),
      ),
      body: _buildScreen(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: _bottomTabs
          .map((tabItem) => _bottomNavigationBarItem(_icon(tabItem), tabItem))
          .toList(),
      onTap: _onSelectTab,
      showUnselectedLabels: false,
      showSelectedLabels: false,
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      IconData icon, TabItem tabItem) {
    final Color color =
        _currentItem == tabItem ? Colors.blueAccent : Colors.black26;

    return BottomNavigationBarItem(icon: Icon(icon, color: color), label: '');
  }

  void _onSelectTab(int index) {
    TabItem selectedTabItem = _bottomTabs[index];

    setState(() {
      _currentItem = selectedTabItem;
    });
  }

  String _setTitle(TabItem item) {
    switch (item) {
      case TabItem.home:
        return "Wallets";
      case TabItem.market:
        return "Market";
      case TabItem.account:
        return "Account";
      default:
        throw 'Unknown $item';
    }
  }

  IconData _icon(TabItem item) {
    switch (item) {
      case TabItem.home:
        return Icons.account_balance_wallet_rounded;
      case TabItem.market:
        return Wallet.chart_line;
      case TabItem.account:
        return Wallet.user;
      default:
        throw 'Unknown $item';
    }
  }

  Widget _buildScreen() {
    switch (_currentItem) {
      case TabItem.home:
        return Home();
      case TabItem.market:
        return MarketPage();
      case TabItem.account:
        return Account();
      default:
        return Home();
    }
  }
}
