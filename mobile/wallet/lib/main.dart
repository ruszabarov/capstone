import 'package:flutter/material.dart';
import 'package:wallet/screens/wrapper.dart';
import 'package:wallet/swatches.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Etherium",
      home: Wrapper(),
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        primarySwatch: myCustomColor,
      ),
    );
  }
}
