import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallet/screens/authentication/auth.dart';
import 'package:provider/src/provider.dart';

class Account extends StatelessWidget {
  final String title = "Account";

  const Account();

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
        )
      ],
    );
  }
}
