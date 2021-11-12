import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wallet/screens/authentication/login.dart';
import 'package:wallet/screens/wrapper.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:web3dart/web3dart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Client httpClient;
    Web3Client ethClient;
    bool data = false;
    int myAmount = 0;
    final myAddress = "0x127Ff1D9560F7992911389BA181f695b38EE9399";

    @override
    void initState() {
      super.initState();
      httpClient = Client();
      ethClient = Web3Client();
    }

    return MaterialApp(
      title: "Crypto Wallet",
      home: LoginPage(),
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(primary: Colors.blueAccent),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
