import 'package:http/http.dart' as http;
import 'dart:convert';

// 22895445-71be-40d1-810a-93ad9df49465

Future<Map<String, dynamic>> getCoinData(String id) async {
  try {
    var url = Uri.parse("https://api.coingecko.com/api/v3/coins/${id}");
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var price = json['market_data']['current_price']['usd'].toString();
    var priceChange =
        json['market_data']['price_change_percentage_24h'].toString();
    var icon = json['image']['small'];
    var result = {
      'current_price': double.parse(price),
      'price_change_percent': double.parse(priceChange),
      'icon': icon,
    };
    return result;
  } catch (e) {
    var result = {
      'current_price': 0.0,
      'price_change_percent': 0.0,
      'icon': ''
    };
    return result;
  }
}

Future<List> getMarketData(String id, String days) async {
  try {
    var url = Uri.parse(
        "https://api.coingecko.com/api/v3/coins/${id}/market_chart?vs_currency=usd&days=${days}");
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var prices = json['prices'];
    return prices;
  } catch (e) {
    var prices = [];
    return prices;
  }
}
