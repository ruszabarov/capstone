import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:wallet/screens/home/home.dart';
import 'package:wallet/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

const users = const {
  '1@1.com': '1234',
};

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late User? user;
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Wrapper(user!),
        ),
      );
    }

    return firebaseApp;
  }

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User does not exist';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) async {
    user = await FireAuth.registerUsingEmailPassword(
        email: data.name!, password: data.password!);
    if (user != null) {
      return null;
    }
    ;

    return "Authentication error";
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return FlutterLogin(
            title: 'Z WALLET',
            onLogin: _authUser,
            onSignup: _signupUser,
            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Wrapper(user!),
              ));
            },
            onRecoverPassword: _recoverPassword,
            theme: LoginTheme(
              primaryColor: Colors.blueAccent,
              accentColor: Colors.white,
              switchAuthTextColor: Colors.black54,
              errorColor: Colors.red,
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
