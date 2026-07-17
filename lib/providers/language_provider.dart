import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LanguageProvider extends ChangeNotifier {
  static const String _languageCodeKey = 'languageCode';

  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  LanguageProvider() {
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_languageCodeKey) ?? 'en';

    _locale = Locale(code);
    notifyListeners();
  }

  Future<void> changeLanguage(String languageCode) async {
    if (_locale.languageCode == languageCode) return;

    _locale = Locale(languageCode);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, languageCode);

    notifyListeners();
  }
}