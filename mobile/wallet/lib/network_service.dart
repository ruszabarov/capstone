import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';

Future<String> changeNetwork(String name) async{
  final String abi = await rootBundle.loadString("assets/build/contracts/networks.json");
  final json = await jsonDecode(abi);
  for (int i = 0; i < json.length; i++) {
    if (json[i]["name"] == name) {
      return json[i]["node"] as String;
    }
  }
  return "Null";
}