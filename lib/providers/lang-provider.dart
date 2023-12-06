import 'package:flutter/material.dart';

class LangProvider extends ChangeNotifier {
  String languageCode = "en";

  void changeLanguage(String code) {
    languageCode = code;
    notifyListeners();
  }
}
