import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallet/providers/Account.dart';
import 'package:wallet/providers/Token.dart';
import 'package:wallet/screens/authentication/auth.dart';
import 'package:wallet/screens/authentication/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:wallet/screens/load_data.dart';
import 'package:wallet/screens/wrapper.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationProvider>().authState,
          initialData: null,
        ),
      ],
      child: MyApp(),
    ),
  );
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
      home: Authenticate(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: context.read<AuthenticationProvider>().authState,
      builder: (context, snapshot) {
        return LoadDataPage();
        //TODO: For some reason this is called twice

        // if (snapshot.connectionState == ConnectionState.active) {
        //   return snapshot.hasData ? LoadDataPage() : LoginPage();
        // } else {
        //   return Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
      },
    );
  }
}
