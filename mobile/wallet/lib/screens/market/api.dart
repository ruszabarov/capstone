import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> getCoinData(String id) async {
  try {
    var url = Uri.parse("https://api.coingecko.com/api/v3/coins/${id}");
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var price = json['market_data']['current_price']['usd'].toString();
    var priceChange =
        json['market_data']['price_change_percentage_24h'].toString();
    var result = {
      'current_price': double.parse(price),
      'price_change_percent': double.parse(priceChange)
    };
    return result;
  } catch (e) {
    var result = {'current_price': 0.0, 'price_change_percent': 0.0};
    return result;
  }
}
