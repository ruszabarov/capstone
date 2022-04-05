import 'package:flutter/cupertino.dart';
import 'package:wallet/providers/Account.dart';

class Token {
  final String name;
  final String adress;
  final String shortName;
  final String iconURL;
  double balance;

  Token(this.name, this.adress, this.shortName, this.balance, this.iconURL);
}

class TokenList extends ChangeNotifier {
  List<Token> _tokenList = [];

  List<Token> get tokenList => _tokenList;

  TokenList(this._tokenList) {}
}

Token ethereum = new Token("ethereum", "asdadasds", 'ETH', 0,
    'assets/images/coin_logos/ethereum.webp');
Token tether = new Token("tether", "aoiahfanbfsf", "USDT", 0,
    'assets/images/coin_logos/tether.webp');
Token polygon = new Token("matic-network", "asjkldhaiouhyvav", "MATIC", 0,
    'assets/images/coin_logos/matic-token.webp');
Token chainlink = new Token("chainlink", "asjkldhaiouhyvav", "LINK", 0,
    'assets/images/coin_logos/chainlink.webp');

var cryptoWallets = [
  ethereum,
];

var accountTwoWallets = [
  ethereum,
  tether,
  polygon,
  chainlink,
];
