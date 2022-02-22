import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:wallet/logic.dart';
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
  Future<void> addAccount();
  Future<void> clearPreferences();
}

class ConfigurationService implements IConfigurationService {
  ConfigurationService(this._preferences, this._encryptedPreferences);

  int accountCounter = 0;
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
    final String allAccounts =
        await _encryptedPreferences.getString('accountList');
    return Account.decode(allAccounts);
  }

  @override
  Future<void> addAccount() async {
    WalletAddress walletAddressService = new WalletAddress();
    accountCounter += 1;
    setMnemonic(walletAddressService.generateMnemonic());
    setPrivateKey(await walletAddressService.getPrivateKey(getMnemonic()!));
    String encodedData = Account.encode([
      Account(
          id: accountCounter,
          privateKey: await getPrivateKey()!,
          publicKey: await walletAddressService
              .getPublicKey(getPrivateKey()!)
              .toString(),
          mnemonic: await getMnemonic()!)
    ]);
    await _encryptedPreferences.setString('accountList', encodedData);
  }

  Future<void> clearPreferences() async {
    await _encryptedPreferences.clear();
    await _preferences.clear();
  }
}

class Account {
  final int id;
  final String privateKey, publicKey, mnemonic;

  Account({
    required this.id,
    required this.privateKey,
    required this.publicKey,
    required this.mnemonic,
  });

  factory Account.fromJson(Map<String, dynamic> jsonData) {
    return Account(
      id: jsonData['id'],
      mnemonic: jsonData['mnemonic'],
      publicKey: jsonData['publicKey'],
      privateKey: jsonData['privateKey'],
    );
  }

  static Map<String, dynamic> toMap(Account account) => {
        'id': account.id,
        'mnemonic': account.mnemonic,
        'publicKey': account.publicKey,
        'privateKey': account.privateKey,
      };

  static String encode(List<Account> accounts) => json.encode(
        accounts
            .map<Map<String, dynamic>>((account) => Account.toMap(account))
            .toList(),
      );

  static List<Account> decode(String accounts) =>
      (json.decode(accounts) as List<dynamic>)
          .map<Account>((item) => Account.fromJson(item))
          .toList();
}
