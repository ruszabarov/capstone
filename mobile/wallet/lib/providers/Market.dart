import 'package:flutter/cupertino.dart';

class Market {
  final String name;
  num currentPrice = 0;
  num priceChangePercent = 0;
  final String iconURL;

  Market(this.name, this.iconURL);
}

class MarketList extends ChangeNotifier {
  Map<String, Market> _markets;

  Map<String, Market> get markets => _markets;

  MarketList(this._markets);
}

Map<String, Market> initMarketData = {
  "ethereum": Market("ethereum", 'assets/images/coin_logos/ethereum.webp'),
  "tether": Market("tether", 'assets/images/coin_logos/tether.webp'),
  "usd-coin": Market("usd-coin", 'assets/images/coin_logos/usd-coin.webp'),
  "binancecoin":
      Market('binancecoin', 'assets/images/coin_logos/binance-coin.webp'),
  "matic-network":
      Market('matic-network', 'assets/images/coin_logos/matic-token.webp'),
  "shiba-inu": Market('shiba-inu', 'assets/images/coin_logos/shiba.webp'),
  "wrapped-bitcoin": Market(
      'wrapped-bitcoin', 'assets/images/coin_logos/wrapped-bitcoin.webp'),
  "chainlink": Market('chainlink', 'assets/images/coin_logos/chainlink.webp'),
};
