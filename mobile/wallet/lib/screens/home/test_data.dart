import 'dart:ffi';

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

class Transaction {
  final String type;
  final String fromAddress;
  final String toAddress;
  final int nonce;
  final double amount;
  final int gasLimit;
  final int gasUsed;
  final double baseFee;
  final double priorityFee;
  final double totalGasFee;
  final double maxFeePerGas;
  final double total;
  final String date;

  Transaction(
      this.type,
      this.fromAddress,
      this.toAddress,
      this.nonce,
      this.amount,
      this.gasLimit,
      this.gasUsed,
      this.baseFee,
      this.priorityFee,
      this.maxFeePerGas,
      this.totalGasFee,
      this.total,
      this.date);
}

Transaction one = Transaction(
    'incoming',
    '0x1541ljkfas523',
    '0xaalfkj3398u1',
    0,
    0.02,
    2100,
    2100,
    0.00000015,
    1.5,
    0.00000031,
    0.0000000002,
    0.0200315,
    '14 December 2022');

Transaction two = Transaction(
    'outgoing',
    '0xaalfkj3398u1',
    '0x1541ljkfas523',
    0,
    0.02,
    2100,
    2100,
    0.00000015,
    1.5,
    0.00000031,
    0.0000000002,
    0.0200315,
    '14 December 2022');

List<Transaction> transactions = [one, two, one, one, one];
