import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'base_viewmodel.dart';

class ThemeConfig extends BaseViewModel {
  ThemeConfig._();

  static final _instance = ThemeConfig._();
  static ThemeConfig get instance => _instance;

  ThemeMode _themeMode = ThemeMode.dark;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    setStatusBar();
    notifyListeners();
  }

  void setStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness:
          _themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
    ));
  }

  ThemeMode get themeMode => _themeMode;
}
