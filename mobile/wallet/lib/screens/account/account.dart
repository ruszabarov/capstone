import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:wallet/providers/Account.dart';
import 'package:wallet/screens/authentication/auth.dart';
import 'package:provider/src/provider.dart';
import 'package:wallet/screens/home/test_data.dart';

class AccountPage extends StatefulWidget {
  const AccountPage();

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final String title = "Account";
  bool testBool = false;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          firebaseUser.toString(),
        ),
        ElevatedButton(
          onPressed: () async {
            // context.read<AuthenticationProvider>().signOut();
            setState(() {
              testBool = !testBool;
            });
          },
          child: Text("Sign out"),
        ),
        Container(
          color: Colors.red,
          height: testBool == true ? 100 : 0,
        ),
        Container(
          child: Text("hello"),
          color: Colors.blue,
        ),
        Ink(
          key: Key("asdadsa"),
          child: Text("hello"),
          color: Colors.green,
        ),
      ],
    );
  }
}
