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
      mainAxisSize: MainAxisSize.min,
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
        // Container(
        //   child: CustomPaint(
        //     size: Size.fromHeight(175),
        //     painter: AccountCardPainter(),
        //   ),
        // ),
      ],
    );
  }
}
