import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:wallet/screens/wrapper.dart';

const users = const {
  '1@1.com': '1234',
};

class LoginPage extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
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
    return FlutterLogin(
      title: 'Z WALLET',
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Wrapper(),
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
}

      // theme: LoginTheme(
      //   primaryColor: Colors.blueAccent,
      //   accentColor: Colors.white,
      //   switchAuthTextColor: Colors.black54,
      //   errorColor: Colors.red,
      //   buttonStyle: TextStyle(
      //     color: Colors.black54,
      //   ),
      //   inputTheme: InputDecorationTheme(
      //     focusedBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: Colors.black54),
      //       borderRadius: BorderRadius.vertical(
      //         bottom: Radius.circular(25),
      //         top: Radius.circular(25),
      //       ),
      //     ),
      //   ),
      //   primaryColorAsInputLabel: true,
      // ),