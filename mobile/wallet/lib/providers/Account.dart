import 'dart:math';

import 'package:flutter/material.dart';
import 'Token.dart';

class Account {
  final String name;
  final String address;
  final double balance;
  final TokenList tokens;
  final List<Color> colorPair = colorPairs[Random().nextInt(colorPairs.length)];

  Account(this.name, this.address, this.balance, this.tokens) {}
}

class AccountList extends ChangeNotifier {
  List<Account> _accounts;

  List<Account> get accounts => _accounts;

  void addAccount(Account account) {
    _accounts.add(account);
    notifyListeners();
  }

  void updateTokenBalance(int index, double newBalance) {
    _accounts[0].tokens.tokenList[index].balance = newBalance;
    notifyListeners();
  }

  AccountList(this._accounts) {}
}

List colorPairs = [
  [Colors.pink.shade200, Colors.pink.shade400],
  [Colors.red.shade200, Colors.red.shade400],
  [Colors.orange.shade200, Colors.orange.shade400],
  [Colors.amber.shade200, Colors.amber.shade400],
  [Colors.yellow.shade300, Colors.yellow.shade500],
  [Colors.lime.shade200, Colors.lime.shade400],
  [Colors.lightGreen.shade200, Colors.lightGreen.shade400],
  [Colors.green.shade200, Colors.green.shade400],
  [Colors.teal.shade200, Colors.teal.shade400],
  [Colors.cyan.shade200, Colors.cyan.shade400],
  [Colors.lightBlue.shade200, Colors.lightBlue.shade400],
  [Colors.blue.shade200, Colors.blue.shade400],
  [Colors.indigo.shade200, Colors.indigo.shade400],
];
