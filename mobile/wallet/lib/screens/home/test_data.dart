import 'package:flutter/material.dart';
import 'package:wallet/wallet_icons.dart';

class CryptoWallet {
  final String name;
  final String balance;
  final String myAdress;
  final IconData icon;

  CryptoWallet(this.name, this.balance, this.myAdress, this.icon);
}

class Transaction {
  final String from;
  final String to;
  final String amount;

  Transaction(this.from, this.to, this.amount);
}

var ethereum =
    new CryptoWallet("ethereum", "100", "adkaldajkdaksda", Icons.money);
var bitcoin =
    new CryptoWallet("bitcoin", "200", "adjlkasdkjasddaasda", Icons.money);
var test =
    new CryptoWallet("test", "testBalance", "asdjlkajsdklas", Icons.money);
var test2 =
    new CryptoWallet("test", "testBalance", "asdjlasdklaj", Icons.money);
var test3 =
    new CryptoWallet("test", "testBalance", "lkajdlkasjdlasd", Icons.money);
var test4 =
    new CryptoWallet("test", "testBalance", "alkjdaklsdjkadas", Icons.money);
var test5 =
    new CryptoWallet("test", "testBalance", "alksdjalkdslad", Icons.money);
var test6 =
    new CryptoWallet("test", "testBalance", "akldjalksdjalsd", Icons.money);
var test7 =
    new CryptoWallet("test", "testBalance", "alkdjalksdajkdaslkd", Icons.money);
var test8 =
    new CryptoWallet("test", "testBalance", "akdjakldajskd", Icons.money);

var cryptoWallets = [
  ethereum,
  bitcoin,
  test,
  test2,
  test3,
  test4,
  test5,
  test6,
  test7,
  test8
];
