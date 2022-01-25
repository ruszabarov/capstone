import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/src/provider.dart';
import 'package:wallet/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    String? user = await context
        .read<AuthenticationProvider>()
        .signInWithEmailAndPassword(email: data.name, password: data.password);

    if (user == "Signed in") {
      return null;
    }

    return "Invalid email or password";
  }

  Future<String?> _signupUser(SignupData data) async {
    String? user = await context
        .read<AuthenticationProvider>()
        .signInWithEmailAndPassword(
            email: data.name!, password: data.password!);
    if (user == "Signed up") {
      return null;
    }

    return "Invalid email or password";
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      // if (!users.containsKey(name)) {
      //   return 'User not exists';
      // }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Z WALLET',
      onLogin: _authUser,
      onSignup: _signupUser,
      onRecoverPassword: _recoverPassword,
      theme: LoginTheme(
        primaryColor: Colors.blueAccent,
        accentColor: Colors.white,
        switchAuthTextColor: Colors.black54,
        errorColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
