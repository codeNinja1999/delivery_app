import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeConfig extends ChangeNotifier {
  SharedPreferences? _sharedPreferences;
  ThemeMode get themeMode => getThemeMode();
  set themeMode(ThemeMode val) {
    notifyListeners();
  }

  ThemeConfig() {
    _init();
  }

  Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _sharedPreferences?.setInt('THEME_MODE', mode.index);
    themeMode = mode;
  }

  ThemeMode getThemeMode() {
    int saved = _sharedPreferences?.getInt('THEME_MODE') ?? 0;
    return ThemeMode.values[saved];
  }
}
