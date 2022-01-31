import 'package:http/http.dart' as http;
import 'dart:convert';

// 22895445-71be-40d1-810a-93ad9df49465

Future<Map<String, dynamic>> getCoinData(String id) async {
  try {
    Uri uri = Uri.parse("https://api.coingecko.com/api/v3/coins/${id}");
    dynamic response = await http.get(uri);
    dynamic json = jsonDecode(response.body);
    num price = json['market_data']['current_price']['usd'];
    num priceChange = json['market_data']['price_change_percentage_24h'];
    String icon = json['image']['small'];
    Map<String, dynamic> result = {
      'current_price': price,
      'price_change_percent': priceChange,
      'icon': icon,
    };
    return result;
  } catch (e) {
    throw (e.toString());
  }
}

Future<Map<String, dynamic>> getSimpleTokenData(String ids) async {
  try {
    Uri uri = Uri.parse(
        "https://api.coingecko.com/api/v3/simple/price?ids=$ids&vs_currencies=usd&include_24hr_change=true");
    dynamic response = await http.get(uri);
    dynamic json = jsonDecode(response.body);
    return json;
  } catch (e) {
    throw (e.toString());
  }
}

Future<List> getMarketData(String id, int days) async {
  String interval = "";
  try {
    if (days == 1) {
      interval = "5min";
    } else if (days <= 30) {
      interval = "hourly";
    } else {
      interval = "daily";
    }

    var url = Uri.parse(
        "https://api.coingecko.com/api/v3/coins/${id}/market_chart?vs_currency=usd&days=${days}&interval=${interval}");
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var prices = json['prices'];
    return prices;
  } catch (e) {
    var prices = [];
    return prices;
  }
}
