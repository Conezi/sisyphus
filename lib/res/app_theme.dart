import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();
  static final _instance = AppTheme._();
  static AppTheme get instance => _instance;

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.lightPrimaryColor,
      canvasColor: AppColors.lightCanvasColor,
      dividerColor: AppColors.lightDividerColor,
      dialogBackgroundColor: AppColors.lightBackgroundColor,
      scaffoldBackgroundColor: AppColors.lightBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'Satoshi',
      colorScheme: const ColorScheme.light(
          secondary: AppColors.lightSecondaryColor,
          primary: AppColors.lightSecondaryColor,
          background: AppColors.lightBackgroundColor,
          brightness: Brightness.light),
      checkboxTheme: ThemeData.light().checkboxTheme.copyWith(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          ),
      appBarTheme: AppBarTheme(
          elevation: 0.0,
          titleTextStyle: ThemeData.light()
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
          iconTheme: ThemeData.light().iconTheme,
          color: AppColors.lightPrimaryColor,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          )));

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.darkPrimaryColor,
      canvasColor: AppColors.darkCanvasColor,
      dividerColor: AppColors.darkDividerColor,
      dialogBackgroundColor: AppColors.darkBackgroundColor,
      scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'Satoshi',
      colorScheme: const ColorScheme.dark(
          secondary: AppColors.darkSecondaryColor,
          primary: AppColors.darkSecondaryColor,
          background: AppColors.darkBackgroundColor,
          brightness: Brightness.dark),
      checkboxTheme: ThemeData.dark().checkboxTheme.copyWith(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          ),
      appBarTheme: AppBarTheme(
          elevation: 0.0,
          titleTextStyle: ThemeData.dark()
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
          iconTheme: ThemeData.dark().iconTheme,
          color: AppColors.darkPrimaryColor,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          )));
}
