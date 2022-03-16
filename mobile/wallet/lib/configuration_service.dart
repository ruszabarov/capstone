import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet/wallet_setup.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();


abstract class IConfigurationService {
  Future<void> setMnemonic(String? value);
  Future<void> setupDone(bool value);
  Future<void> setPrivateKey(String? value);
  Future<String?> getMnemonic();
  Future<String?> getPrivateKey();
  bool didSetupWallet();
  Future<List<Account>> getAllAccounts();
  Future<void> addAccount(String name);
  Future<void> clearPreferences();
  Future<void> firstAccount(String name);
  Future<void> importAccount(String privateKey, String name);
  Future<void> addToken(
      int id, String name, String symbol, String address, int decimals);
  Future<List<Token>> getTokens();
  Future<void> addEther(int id);
}

class ConfigurationService implements IConfigurationService {
  ConfigurationService(this._preferences);


  final SharedPreferences _preferences;

  @override
  Future<void> setMnemonic(String? value) async {
    if(await _preferences.getBool("isLoggedIn")!) {
      await storage.write(key: 'mnemonic', value: value ?? '');
    }
  }

  @override
  Future<void> setPrivateKey(String? value) async {
    if(await _preferences.getBool("isLoggedIn")!) {
      await storage.write(key: 'privateKey', value: value ?? '');
    }
  }

  @override
  Future<void> setupDone(bool value) async {
    await _preferences.setBool('didSetupWallet', value);
  }

  // gets
  @override
  Future<String?> getMnemonic() async {
    try {
      if(await _preferences.getBool("isLoggedIn")!) {
        return storage.read(key: 'mnemonic');
      }
      return null;
    } catch (e) {
      return "error";
    } 
  }

  @override
  Future<String?> getPrivateKey() async{
    try {
      if(await _preferences.getBool("isLoggedIn")!) {
        return storage.read(key: 'privateKey');
      }
      return null;
    } catch (e) {
      return "error";
    }
  }

  @override
  bool didSetupWallet() {
    return _preferences.getBool('didSetupWallet') ?? false;
  }

  @override
  Future<List<Account>> getAllAccounts() async {
    List<Account> accounts = await Account.decode(
        await storage.read(key: 'accountList'));
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
          privateKey: await walletAddressService.getPrivateKey(await getMnemonic() as String),
          publicKey: await walletAddressService
              .getPublicKey(
                  await walletAddressService.getPrivateKey(await getMnemonic() as String))
              .toString(),
          mnemonic: await getMnemonic() as String)
    ]);
    await storage.write(key: 'accountList', value: encodedData);
  }

  @override
  Future<void> importAccount(String privateKey, String name) async {
    WalletAddress walletAddressService = new WalletAddress();
    List<Account> acc = [];
    if ((await storage.read(key: 'accountList') != null)) {
      acc = await Account.decode(
          await storage.read(key: 'accountList'));
    }

    acc.add(Account(
        id: acc.length + 1,
        name: name,
        privateKey: privateKey,
        publicKey: await walletAddressService
            .getPublicKey(
                await walletAddressService.getPrivateKey(getMnemonic() as String))
            .toString(),
        mnemonic: await getMnemonic() as String));
    String encodedData = Account.encode(acc);
    await storage.write(key: 'accountList', value: encodedData);
  }

  @override
  Future<void> addAccount(String name) async {
    WalletAddress walletAddressService = new WalletAddress();
    setPrivateKey(await walletAddressService.getPrivateKey(getMnemonic() as String));

    List<Account> acc = await Account.decode(
        await storage.read(key: 'accountList'));
    acc.add(Account(
        id: acc.length + 1,
        name: name,
        privateKey: await getPrivateKey() as String,
        publicKey: await walletAddressService
            .getPublicKey(getPrivateKey() as String)
            .toString(),
        mnemonic: await getMnemonic() as String));

    String encodedData = Account.encode(acc);

    await storage.write(key: 'accountList', value: encodedData);
  }

  Future<void> clearPreferences() async {
    await _preferences.clear();
  }

  @override
  Future<void> addEther(int id) async {
    
    List<Token> tokenList = [];
    tokenList.add(Token(
        id: id,
        name: "Ether",
        symbol: "ETH",
        address: "0x0000000000000",
        decimals: 18));

    String encodedData = Token.encode(tokenList);
    await _preferences.setString('tokenList', encodedData);
  }

  @override
  Future<void> addToken(
      int id, String name, String symbol, String address, int decimals) async {
    
    List<Token> tokenList =
        await Token.decode(await _preferences.getString('tokenList'));
    tokenList.add(Token(
        id: id,
        name: name,
        symbol: symbol,
        address: address,
        decimals: decimals));

    String encodedData = Token.encode(tokenList);
    await _preferences.setString('tokenList', encodedData);
  }

  Future<List<Token>> getTokens() async {
    List<Token> tokens = await Token.decode(
        await _preferences.getString('tokenList'));
    return tokens;
  }
}

class Account {
  final int id;
  final String privateKey, publicKey, mnemonic, name;

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
