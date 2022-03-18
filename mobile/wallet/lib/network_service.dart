import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class INetworkService {
  Future<void> addNetwork(String name, String node, int id);
  Future<List<Network>> getNetworks();
}

class NetworkService implements INetworkService {
  NetworkService(this._preferences);
  final SharedPreferences _preferences;

  Future<void> addNetwork(String name, String node, int id) async {
     List<Network> networkList = [];
    if(await _preferences.getString('networkList') == null) {
      print("Network list is empty");
      networkList.add(Network(ChainID: 1, name: "mainnet", node: "https://eth-mainnet.gateway.pokt.network/v1/lb/6212b3749c8d48003a41d3b2"));
      // String encodedData = Network.encode([Network(ChainID: 1, name: "1", node: "https://eth-mainnet.gateway.pokt.network/v1/lb/6212b3749c8d48003a41d3b2")]);
      String encodedData = await Network.encode(networkList);
      await _preferences.setString("networkList", encodedData);
    }
    networkList =
        await Network.decode(await _preferences.getString('networkList'));
    networkList.add(Network(
        ChainID: id,
        name: name,
        node: node,
        )
      );

    String encodedData = Network.encode(networkList);
    await _preferences.setString('networkList', encodedData);
  }

  Future<List<Network>> getNetworks() async{
    List<Network> networks = await Network.decode(
        await _preferences.getString('tokenList'));
    return networks;
  }
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