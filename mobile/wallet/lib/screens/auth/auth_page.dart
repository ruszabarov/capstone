import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet/configuration_service.dart';
import 'package:wallet/screens/auth/password_page.dart';
import 'package:wallet/screens/load_data.dart';
import 'package:wallet/screens/shared/appBar.dart';
import 'package:wallet/screens/shared/card.dart';
import 'package:wallet/screens/shared/neumorphic_card.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticating = false;

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
      });
      authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
      });

      if (authenticated == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", true);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return LoadDataPage();
            },
          ),
        );
      }
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
      });
      return;
    }
    if (!mounted) {
      return;
    }
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  Future<void> _usePassword() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return PasswordPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Z WALLET",
                style: TextStyle(
                  fontSize: 38,
                  color: Colors.grey[200],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(7, 7),
                      blurRadius: 20,
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (_isAuthenticating)
                        NeumorphicButton(
                          style: NeumorphicStyle(
                            color: Colors.blueAccent,
                            shadowLightColor: Colors.white.withOpacity(0.7),
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(15)),
                            depth: 4,
                          ),
                          padding: EdgeInsets.all(20),
                          onPressed: () {
                            _cancelAuthentication();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Cancel",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[200],
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        NeumorphicButton(
                          style: NeumorphicStyle(
                            color: Colors.blueAccent,
                            shadowLightColor: Colors.white.withOpacity(0.7),
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(15)),
                            depth: 4,
                          ),
                          padding: EdgeInsets.all(20),
                          onPressed: () {
                            _authenticate();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Unlock",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[200],
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      NeumorphicButton(
                        style: NeumorphicStyle(
                          color: Colors.grey[200],
                          shadowLightColor: Colors.white.withOpacity(0.7),
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(15)),
                          depth: 4,
                        ),
                        padding: EdgeInsets.all(20),
                        onPressed: () {
                          _usePassword();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Use Password",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
