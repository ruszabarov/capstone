import 'package:flutter/material.dart';

Widget appBar({Widget? left, required String title}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(fontSize: 30, color: Colors.white),
    ),
    centerTitle: true,
    toolbarHeight: 75,
    backgroundColor: Colors.blueAccent,
    foregroundColor: Colors.white,
  );
}
