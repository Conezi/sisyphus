import 'package:flutter/material.dart';

class AppColors {
  static const Color lightPrimaryColor = Color(0xffffffff);
  static const Color lightBackgroundColor = Color(0xfffcfafa);
  static const Color lightCanvasColor = Color(0xffF1F1F1);
  static const Color lightDividerColor = Color(0xffF1F1F1);

  static const Color darkPrimaryColor = Color(0xff17181B);
  static const Color darkBackgroundColor = Color(0xff262932);
  static const Color darkCanvasColor = Color(0xff20252B);
  static const Color darkDividerColor = Color(0xff262932);

  static const Color secondaryColor = Color(0xffCFD3D8);
  static const Color green = Color(0xff00C076);
  static const Color orange = Color(0xffFF6838);

  static LinearGradient buttonGradient = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[
        Color(0xff483BEB),
        Color(0xff7847E1),
        Color(0xffDD568D)
      ],
      stops: [
        0.3,
        0.8,
        1,
      ]);
}
