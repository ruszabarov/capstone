import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:wallet/providers/Account.dart';
import 'package:wallet/screens/authentication/auth.dart';
import 'package:provider/src/provider.dart';
import 'package:wallet/screens/home/test_data.dart';

class AccountPage extends StatelessWidget {
  final String title = "Account";

  const AccountPage();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    return Column(
      children: [
        Text(
          firebaseUser.toString(),
        ),
        ElevatedButton(
          onPressed: () async {
            context.read<AuthenticationProvider>().signOut();
          },
          child: Text("Sign out"),
        ),
        Consumer<AccountList>(builder: (context, accounts, child) {
          return Text(accounts.accounts[0].balance.toString());
        }),
      ],
    );
  }
}
