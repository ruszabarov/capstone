import 'package:flutter/material.dart';

Widget appBar({Widget? left, required String title}) {
  return Container(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 25,
            child: left,
          ),
          Text(
            '$title',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: 25,
          ),
        ],
      ),
    ),
  );
}
