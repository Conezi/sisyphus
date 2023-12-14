import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();
  static final _instance = AppTheme._();
  static AppTheme get instance => _instance;

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.lightPrimary,
      canvasColor: AppColors.lightCanvas,
      dialogBackgroundColor: AppColors.lightBackground,
      scaffoldBackgroundColor: AppColors.lightBackground,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'Satoshi',
      colorScheme: const ColorScheme.light(
          secondary: AppColors.secondaryColor,
          primary: AppColors.secondaryColor,
          background: AppColors.lightBackground,
          brightness: Brightness.light),
      appBarTheme: AppBarTheme(
          elevation: 0.0,
          titleTextStyle: ThemeData.light()
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
          iconTheme: ThemeData.light().iconTheme,
          color: AppColors.lightPrimary,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          )));

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.darkPrimary,
      canvasColor: AppColors.darkCanvas,
      dialogBackgroundColor: AppColors.darkBackground,
      scaffoldBackgroundColor: AppColors.darkBackground,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'Satoshi',
      colorScheme: const ColorScheme.light(
          secondary: AppColors.secondaryColor,
          primary: AppColors.secondaryColor,
          background: AppColors.darkBackground,
          brightness: Brightness.dark),
      appBarTheme: AppBarTheme(
          elevation: 0.0,
          titleTextStyle: ThemeData.dark()
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
          iconTheme: ThemeData.dark().iconTheme,
          color: AppColors.darkPrimary,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          )));
}
