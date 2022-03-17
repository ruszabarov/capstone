import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';

// Future<void> addNetwork 

Future<String> changeNetwork(int id) async{
  final String abi = await rootBundle.loadString("assets/build/contracts/networks.json");
  final json = await jsonDecode(abi);
  for (int i = 0; i < json.length; i++) {
    if (json[i]["id"] == id) {
      return json[i];
    }
  }
  return "Null";
}

class Network {
  String name;
  String node;
  int ChainID;

  Network({
    required this.ChainID,
    required this.name,
    required this.node,
  });

  factory Network.fromJson(Map<String, dynamic> jsonData) {
    return Network(
      ChainID: jsonData['ChainID'],
      name: jsonData['name'],
      node: jsonData['node'],
    );
  }

  static Map<String, dynamic> toMap(Network network) => {
        'ChainID': network.ChainID,
        'name': network.name,
        'node': network.node,
      };

  static String encode(List<Network> networks) => json.encode(
        networks
            .map<Map<String, dynamic>>((network) => Network.toMap(network))
            .toList(),
      );

  static List<Network> decode(String? networks) =>
      (json.decode(networks!) as List<dynamic>)
          .map<Network>((item) => Network.fromJson(item))
          .toList();
}