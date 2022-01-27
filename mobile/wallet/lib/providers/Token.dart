import 'package:flutter/cupertino.dart';

class Token {
  final String name;
  final String adress;
  final String shortName;
  double balance;

  Token(this.name, this.adress, this.shortName, this.balance);
}

class TokenList extends ChangeNotifier {
  List<Token> _tokenList = [];

  List<Token> get tokenList => _tokenList;

  TokenList(this._tokenList) {}
}
