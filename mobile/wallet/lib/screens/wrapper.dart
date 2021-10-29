import 'package:flutter/material.dart';
import 'package:wallet/screens/account/account.dart';
import 'package:wallet/wallet_icons.dart';
import 'package:wallet/screens/home/home.dart';

class Wrapper extends StatefulWidget {
  @override
  State createState() {
    return _WrapperState();
  }
}

class _WrapperState extends State {
  int _currentIndex = 0;
  String _currentTitle = "";

  final List _children = [
    Home(),
    Account(),
    Account(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _currentTitle = _children[index].title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentTitle),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_rounded),
            label: 'Wallet',
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
        selectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
