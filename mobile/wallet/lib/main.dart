import 'package:flutter/material.dart';
import 'package:wallet/screens/authentication/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Crypto Wallet",
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(primary: Colors.blueAccent),
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
      ),
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => LoginPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
