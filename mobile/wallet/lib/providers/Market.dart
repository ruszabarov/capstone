import 'package:flutter/cupertino.dart';

class Market {
  final String name;
  double currentPrice = 0;
  double priceChangePercent = 0;
  final String iconURL;

  Market(this.name, this.iconURL);
}

class MarketList extends ChangeNotifier {
  List<Market> _markets;

  List<Market> get markets => _markets;

  MarketList(this._markets);
}

List<Market> initMarketData = [
  Market("ethereum", 'assets/images/coin_logos/ethereum.webp'),
  Market("tether", 'assets/images/coin_logos/tether.webp'),
  Market("usd-coin", 'assets/images/coin_logos/usd-coin.webp'),
  Market('binancecoin', 'assets/images/coin_logos/binance-coin.webp'),
  Market('matic-network', 'assets/images/coin_logos/matic-token.webp'),
  Market('shiba-inu', 'assets/images/coin_logos/shiba.webp'),
  Market('wrapped-bitcoin', 'assets/images/coin_logos/wrapped-bitcoin.webp'),
  Market('chainlink', 'assets/images/coin_logos/chainlink.webp')
];
