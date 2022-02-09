import 'package:flutter/material.dart';

Widget appBar({Widget? left, required String title, IconButton? right}) {
  return AppBar(
    title: Padding(
      padding: EdgeInsets.only(left: 15),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    ),
    toolbarHeight: 80,
    elevation: 0,
    backgroundColor: Colors.blueGrey[50],
    foregroundColor: Colors.black,
  );
}
