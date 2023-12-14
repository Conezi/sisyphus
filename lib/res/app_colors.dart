import 'package:flutter/material.dart';

class AppColors {
  static const Color lightPrimary = Color(0xfffcfafa);
  static const Color lightBackground = Color(0xfffcfafa);
  static const Color lightCanvas = Color(0xffffffff);

  static const Color darkPrimary = Color(0xff17181B);
  static const Color darkBackground = Color(0xff262932);
  static const Color darkCanvas = Color(0xff20252B);

  static const Color secondaryColor = Color(0xffDD568D);

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
