import 'package:flutter/material.dart';

Widget card(
    {double width = double.infinity,
    double padding = 20,
    required Widget child}) {
  return Ink(
    width: width,
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15))),
    child: child,
  );
}
