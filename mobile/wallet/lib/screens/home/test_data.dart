import 'package:flutter/material.dart';
import 'package:wallet/logic.dart';
import 'package:wallet/wallet_icons.dart';

class CryptoWallet {
  final String name;
  dynamic balance;
  final String adress;
  final IconData icon;
  final String shortName;

  CryptoWallet(this.name, this.balance, this.adress, this.icon, this.shortName);
}

Future<String> getEtherBalance() async {
  String testBalance = await getEthBalance(myAddress1);
  return testBalance;
}

Future<String> getMyTokenBalance() async {
  String testBalance = await getTokenBalance(myAddress1, "ChainLink Token");
  return testBalance;
}

CryptoWallet ethereum = new CryptoWallet(
    "ethereum", getMyTokenBalance(), "adkaldajkdaksda", Wallet.ethereum, 'ETH');
CryptoWallet bitcoin = new CryptoWallet(
    "bitcoin", getEtherBalance(), "adjlkasdkjasddaasda", Wallet.bitcoin, 'BTC');
CryptoWallet test = new CryptoWallet(
    "test", "1", "asdjlkajsdklas", Icons.attach_money_rounded, 'TST');

var cryptoWallets = [
  ethereum,
  bitcoin,
  test,
  test,
  test,
];

var accountTwo = [
  bitcoin,
  ethereum,
  test,
];

class Account {
  final String name;
  final String address;
  final double balance;
  final List<CryptoWallet> wallets;

  Account(this.name, this.address, this.balance, this.wallets);
}

Account mainAccount =
    Account("Main Account", "0x38953792983228592", 2250.12, cryptoWallets);
Account secondAccount =
    Account("Second Account", "0x2378429832295292", 1023.68, accountTwo);

var accounts = [
  mainAccount,
  secondAccount,
];
