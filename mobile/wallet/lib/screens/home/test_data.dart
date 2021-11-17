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

var ethereum = new CryptoWallet(
    "ethereum", "200", "adkaldajkdaksda", Wallet.ethereum, 'ETH');
var bitcoin = new CryptoWallet(
    "bitcoin", "200", "adjlkasdkjasddaasda", Wallet.bitcoin, 'BTC');
var test = new CryptoWallet(
    "test", "1", "asdjlkajsdklas", Icons.attach_money_rounded, 'TST');

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
