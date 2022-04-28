import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet/providers/Account.dart';
import 'package:wallet/providers/Token.dart';
import 'package:wallet/screens/auth/auth_page.dart';
import 'package:wallet/screens/load_data.dart';
import 'package:flutter/services.dart';

import 'configuration_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ConfigurationService configurationService =
      await ConfigurationService(await SharedPreferences.getInstance());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) {
      runApp(
        Provider.value(
          value: configurationService,
          child: MyApp(),
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TokenList>(
          create: (context) => TokenList([]),
        ),
        ChangeNotifierProvider<AccountList>(
          create: (context) => AccountList([]),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthPage();
    // return StreamBuilder<User?>(
    //   stream: context.read<AuthenticationProvider>().authState,
    //   builder: (context, snapshot) {
    //     return LoadDataPage();
    //     //TODO: For some reason this is called twice

    //     // if (snapshot.connectionState == ConnectionState.active) {
    //     //   return snapshot.hasData ? LoadDataPage() : LoginPage();
    //     // } else {
    //     //   return Center(
    //     //     child: CircularProgressIndicator(),
    //     //   );
    //     // }
    //   },
    // );
  }
}
