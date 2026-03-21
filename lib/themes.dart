import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themes with ChangeNotifier {
  bool _darkMode = true;
  int _currentThemeIndex = 0;

  Themes() {
    load();
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("darkMode", darkMode);
    prefs.setInt("currentThemeIndex", currentThemeIndex);
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    darkMode = prefs.getBool("darkMode") ?? true;
    currentThemeIndex = prefs.getInt("currentThemeIndex") ?? 0;
  }

  bool get darkMode => _darkMode;
  int get currentThemeIndex => _currentThemeIndex;

  set darkMode(bool value) {
    _darkMode = value;
    save();
    notifyListeners();
  }

  set currentThemeIndex(int index) {
    _currentThemeIndex = index;
    save();
    notifyListeners();
  }
}

final themes = [
  Colors.amber,
  Colors.blue,
  Colors.blueGrey,
  Colors.brown,
  Colors.cyan,
  Colors.deepOrange,
  Colors.deepPurple,
  Colors.green,
  Colors.grey,
  Colors.indigo,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.lime,
  Colors.orange,
  Colors.pink,
  Colors.purple,
  Colors.red,
  Colors.teal,
  Colors.yellow,
];
