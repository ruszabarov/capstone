import 'dart:convert';
import 'dart:async';
import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:wallet/logic.dart';
import 'package:wallet/private.dart';
import 'package:wallet/wallet_setup.dart';
import 'package:web3dart/credentials.dart';

abstract class IConfigurationService {
  Future<void> setMnemonic(String? value);
  Future<void> setupDone(bool value);
  Future<void> setPrivateKey(String? value);
  String? getMnemonic();
  String? getPrivateKey();
  bool didSetupWallet();
  Future<List<Account>> getAllAccounts();
  Future<void> addAccount(String name);
  Future<void> clearPreferences();
  Future<void> firstAccount(String name);
  Future<void> importAccount(String privateKey, String name);
  Future<void> addToken(int id, String name, String symbol, String address, int decimals);
}

class ConfigurationService implements IConfigurationService {
  ConfigurationService(this._preferences, this._encryptedPreferences);

  final SharedPreferences _preferences;
  final EncryptedSharedPreferences _encryptedPreferences;

  @override
  Future<void> setMnemonic(String? value) async {
    await _preferences.setString('mnemonic', value ?? '');
  }

  @override
  Future<void> setPrivateKey(String? value) async {
    await _preferences.setString('privateKey', value ?? '');
  }

  @override
  Future<void> setupDone(bool value) async {
    await _preferences.setBool('didSetupWallet', value);
  }

  // gets
  @override
  String? getMnemonic() {
    return _preferences.getString('mnemonic');
  }

  @override
  String? getPrivateKey() {
    return _preferences.getString('privateKey');
  }

  @override
  bool didSetupWallet() {
    return _preferences.getBool('didSetupWallet') ?? false;
  }

  @override
  Future<List<Account>> getAllAccounts() async {
    List<Account> accounts = await Account.decode(await _encryptedPreferences.getString('accountList'));
    return accounts;
  }

  @override
  Future<void> firstAccount(String name) async {
    WalletAddress walletAddressService = new WalletAddress();
    setMnemonic(walletAddressService.generateMnemonic());

    String encodedData = Account.encode([
      Account(
          id: 1,
          name: name,
          privateKey: await walletAddressService.getPrivateKey(getMnemonic()!),
          publicKey: await walletAddressService
              .getPublicKey(await walletAddressService.getPrivateKey(getMnemonic()!))
              .toString(),
          mnemonic: await getMnemonic()!)
    ]);
    await _encryptedPreferences.setString('accountList', encodedData);
  }

  @override
  Future<void> importAccount(String privateKey, String name) async {
    WalletAddress walletAddressService = new WalletAddress();
    List<Account> acc = [];
    if((await _encryptedPreferences.getString('accountList')).isNotEmpty) {
      acc = await Account.decode(await _encryptedPreferences.getString('accountList'));
    }

    acc.add(
      Account(
          id: acc.length + 1,
          name: name,
          privateKey: privateKey,
          publicKey:  await walletAddressService
              .getPublicKey(await walletAddressService.getPrivateKey(getMnemonic()!))
              .toString(),
          mnemonic: await getMnemonic()!)
    );
    String encodedData = Account.encode(acc);
    await _encryptedPreferences.setString('accountList', encodedData);
  }


  @override
  Future<void> addAccount(String name) async {
    WalletAddress walletAddressService = new WalletAddress();
    setPrivateKey(await walletAddressService.getPrivateKey(getMnemonic()!));
    
  
    List<Account> acc = await Account.decode(await _encryptedPreferences.getString('accountList'));
    acc.add(
      Account(
        id: acc.length + 1,
        name: name, 
        privateKey: await getPrivateKey()!, 
        publicKey: await walletAddressService
              .getPublicKey(getPrivateKey()!)
              .toString(), 
        mnemonic: await getMnemonic()!));

    String encodedData = Account.encode(acc);

    await _encryptedPreferences.setString('accountList', encodedData);
  }


  Future<void> clearPreferences() async {
    await _encryptedPreferences.clear();
    await _preferences.clear();
  }

  @override
  Future<void> addToken(int id, String name, String symbol, String address, int decimals) async {
    List<Token> tokenList = await Token.decode(await _encryptedPreferences.getString('tokenList'));
    tokenList.add(
      Token(id: id, name: name, symbol: symbol, address: address, decimals: decimals)
    );

    String encodedData = Token.encode(tokenList);
    await _encryptedPreferences.setString('tokenList', encodedData);
  }
}


class Account {
  final int id;
  final String privateKey, publicKey, mnemonic,name;

  Account({
    required this.id,
    required this.name,
    required this.privateKey,
    required this.publicKey,
    required this.mnemonic,
  });

  factory Account.fromJson(Map<String, dynamic> jsonData) {
    return Account(
      id: jsonData['id'],
      name: jsonData['name'],
      mnemonic: jsonData['mnemonic'],
      publicKey: jsonData['publicKey'],
      privateKey: jsonData['privateKey'],
    );
  }

  static Map<String, dynamic> toMap(Account account) => {
        'id': account.id,
        'name': account.name,
        'mnemonic': account.mnemonic,
        'publicKey': account.publicKey,
        'privateKey': account.privateKey,
      };

  static String encode(List<Account> accounts) => json.encode(
        accounts
            .map<Map<String, dynamic>>((account) => Account.toMap(account))
            .toList(),
      );

  static List<Account> decode(String? accounts) =>
      (json.decode(accounts!) as List<dynamic>)
          .map<Account>((item) => Account.fromJson(item))
          .toList();
}

class Token {
  String name;
  String symbol;
  String address;
  int decimals, id;

  Token({
    required this.id,
    required this.name,
    required this.symbol,
    required this.address,
    required this.decimals,
  });

  factory Token.fromJson(Map<String, dynamic> jsonData) {
    return Token(
      id: jsonData['id'],
      name: jsonData['name'],
      symbol: jsonData['symbol'],
      address: jsonData['address'],
      decimals: jsonData['decimals'],
    );
  }

  static Map<String, dynamic> toMap(Token token) => {
        'id': token.id,
        'name': token.name,
        'symbol': token.symbol,
        'address': token.address,
        'decimals': token.decimals,
      };

  static String encode(List<Token> tokens) => json.encode(
        tokens
            .map<Map<String, dynamic>>((token) => Token.toMap(token))
            .toList(),
      );

  static List<Token> decode(String? tokens) =>
      (json.decode(tokens!) as List<dynamic>)
          .map<Token>((item) => Token.fromJson(item))
          .toList();  
}
