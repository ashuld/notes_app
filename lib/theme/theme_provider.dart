import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notes_app/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late SharedPreferences _prefs;
  ThemeData _themeData = lightMode; // Provide a default value here

  ThemeProvider() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final themeName = _prefs.getString('theme');
      _themeData = themeName == 'dark' ? darkMode : lightMode;
    } catch (e) {
      log('Error initializing SharedPreferences: $e');
    }
    notifyListeners();
  }

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
    _prefs.setString('theme', isDarkMode ? 'dark' : 'light');
  }

  void toggleTheme() {
    themeData = isDarkMode ? lightMode : darkMode;
  }
}
