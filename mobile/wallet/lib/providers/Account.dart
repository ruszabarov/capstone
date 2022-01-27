import 'package:flutter/material.dart';
import 'Token.dart';

class Account {
  final String name;
  final String address;
  final double balance;
  final TokenList tokens;

  Account(this.name, this.address, this.balance, this.tokens);
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
