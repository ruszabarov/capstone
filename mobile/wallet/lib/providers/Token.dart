import 'package:flutter/cupertino.dart';
import 'package:wallet/providers/Account.dart';
import 'package:wallet/configuration_service.dart';

class TokenList extends ChangeNotifier {
  List<Token> _tokenList = [];

  List<Token> get tokenList => _tokenList;

  TokenList(this._tokenList) {}
}
