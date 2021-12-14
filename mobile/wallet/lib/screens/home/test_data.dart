import 'package:flutter/material.dart';
import 'package:wallet/logic.dart';
import 'package:wallet/wallet_icons.dart';

class CryptoWallet {
  final String name;
  String balance;
  final String adress;
  final IconData icon;
  final String shortName;

  CryptoWallet(this.name, this.balance, this.adress, this.icon, this.shortName);
}

var ethereum = new CryptoWallet(
    "ethereum", "201", "adkaldajkdaksda", Wallet.ethereum, 'ETH');
var bitcoin = new CryptoWallet(
    "bitcoin", "100", "adjlkasdkjasddaasda", Wallet.bitcoin, 'BTC');
var test = new CryptoWallet(
    "test", "100", "asdjlkajsdklas", Icons.attach_money_rounded, 'TST');

var cryptoWallets = [
  ethereum,
  bitcoin,
  test,
  test,
  test,
  test,
  test,
  test,
  test,
  test
];
