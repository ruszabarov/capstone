import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallet/screens/authentication/auth.dart';
import 'package:wallet/screens/authentication/login.dart';
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
          // Provider.of<User?>(context).toString(),
          firebaseUser.toString(),
        ),
        ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
          child: Text("Sign out"),
        )
      ],
    );
  }
}
