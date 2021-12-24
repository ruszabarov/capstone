import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallet/screens/authentication/login.dart';

class Account extends StatelessWidget {
  final String title = "Account";
  final User user;

  const Account(this.user);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(user.email!),
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
