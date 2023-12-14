import 'package:flutter/material.dart';

import 'base_viewmodel.dart';

class ThemeConfig extends BaseViewModel {
  ThemeConfig._();

  static final _instance = ThemeConfig._();
  static ThemeConfig get instance => _instance;

  ThemeMode _themeMode = ThemeMode.light;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  ThemeMode get themeMode => _themeMode;
}
