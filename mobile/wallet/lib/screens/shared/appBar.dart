import 'package:flutter/material.dart';

Widget appBar({Widget? left, required String title, IconButton? right}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
    centerTitle: true,
    toolbarHeight: 50,
    elevation: 1,
    backgroundColor: Colors.blueAccent,
    foregroundColor: Colors.white,
  );
}
