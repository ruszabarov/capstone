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

var ethereum = new CryptoWallet(
    "ethereum", getEtherBalance(), "adkaldajkdaksda", Wallet.ethereum, 'ETH');
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
