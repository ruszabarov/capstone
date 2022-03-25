import 'dart:convert';
import 'package:wallet/providers/Token.dart';
import 'private.dart';
import 'package:etherscan_api/etherscan_api.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final etherscan =
    EtherscanAPI(apiKey: apiKey, chain: EthChain.rinkeby, enableLogs: false);
final myAddress = "0x127Ff1D9560F7992911389BA181f695b38EE9399";

void getReceipt(String txhash) async {}
