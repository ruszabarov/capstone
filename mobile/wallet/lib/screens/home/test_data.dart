import 'package:flutter/material.dart';
import 'package:wallet/wallet_icons.dart';

class CryptoWallet {
  final String name;
  final String balance;
  final String adress;
  final IconData icon;
  final String shortName;

  CryptoWallet(this.name, this.balance, this.adress, this.icon, this.shortName);
}

CryptoWallet ethereum = new CryptoWallet(
    "ethereum", "201", "adkaldajkdaksda", Wallet.ethereum, 'ETH');
CryptoWallet bitcoin = new CryptoWallet(
    "bitcoin", "200", "adjlkasdkjasddaasda", Wallet.bitcoin, 'BTC');
CryptoWallet test = new CryptoWallet(
    "test", "1", "asdjlkajsdklas", Icons.attach_money_rounded, 'TST');

var cryptoWallets = [
  ethereum,
  bitcoin,
  test,
  test,
  test,
];

class Account {
  final String name;
  final String address;
  final double balance;

  Account(this.name, this.address, this.balance);
}

Account mainAccount = Account("Main Account", "0x38953792983228592", 2250.12);
Account secondAccount =
    Account("Second Account", "0x2378429832295292", 1023.68);

var accounts = [
  mainAccount,
  secondAccount,
];
