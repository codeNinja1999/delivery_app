import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeConfig extends ChangeNotifier {
  SharedPreferences? _sharedPreferences;

  ThemeMode get themeMode => getThemeMode();
  set themeMode(ThemeMode val) {
    notifyListeners();
  }

  ThemeConfig() {
    initThemeConfig();
  }

  void initThemeConfig() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void setThemeMode(ThemeMode mode) {
    _sharedPreferences?.setInt('THEME_MODE', mode.index);
    themeMode = mode;
  }

  ThemeMode getThemeMode() {
    int option = _sharedPreferences?.getInt('THEME_MODE') ?? 0;
    return ThemeMode.values[option];
  }
}
