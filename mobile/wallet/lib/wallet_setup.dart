import 'dart:typed_data';

import 'package:wallet/logic.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:async';
import 'dart:math';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import "package:hex/hex.dart";

abstract class WalletAddressService {
  String generateMnemonic();
  Future<String> getPrivateKey(String mnemonic);
  Future<String> getPublicKey(String privateKey);
  Future<String> deriveChildWallet(String privateKey, int accountId);
}

class WalletAddress implements WalletAddressService {
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);

    // final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    // final privateKey = HEX.encode(master.key);

    bip32.BIP32 node = bip32.BIP32.fromSeed(seed);
    bip32.BIP32 child = node.derivePath("m/44'/60'/0'/0/0");
    final privateKey = HEX.encode(child.privateKey as List<int>);

    return privateKey;
  }

  Future<String> deriveChildWallet(String mnemonic, int accountId) async {
    final seed = bip39.mnemonicToSeed(mnemonic);    
    bip32.BIP32 node = bip32.BIP32.fromSeed(seed);
    bip32.BIP32 child = node.derivePath("m/44'/60'/0'/"+ accountId.toString() +"/0");
    final privateKey = HEX.encode(child.privateKey as List<int>);

    return privateKey;
  }

  Future<String> getPublicKey(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = await private.extractAddress();

    return address.hex.toString();
  }
}
