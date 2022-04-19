import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet/configuration_service.dart';

class TokenList extends ChangeNotifier {
  late List<Token> _tokens;

  List<Token> get tokens => _tokens;

  TokenList(this._tokens) {
    loadTokens();
  }

  Future<void> loadTokens() async {
    _tokens = await ConfigurationService(await SharedPreferences.getInstance())
        .getAllTokens();
    notifyListeners();
  }
}
