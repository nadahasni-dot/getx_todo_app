import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _isLogin = 'IS_LOGIN';
  static const String _isDarkMode = 'IS_DARK_MODE';
  static const String _locale = 'LOCALE';

  static Future<bool> checkIsLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_isLogin) ?? false;
  }

  static Future<void> saveSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isLogin, true);
  }

  static Future<void> clearSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<bool> checkIsDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDarkMode) ?? false;
  }

  static Future<void> setDarkMode(bool isDarkMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isDarkMode, isDarkMode);
  }

  static Future<Locale> getPreferredLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String preferredLocale = prefs.getString(_locale) ?? 'id';

    return (preferredLocale == 'id'
        ? const Locale('id', 'ID')
        : const Locale('en', 'US'));
  }

  static Future<void> setPreferredLocale(String locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_locale, locale);
  }
}
