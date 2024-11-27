import 'package:flutter/material.dart';

class CustomColors {
  static const Color darkBlue = Color(0xFF00008B);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightBlue = Color(0xFFADD8E6);
  static const Color blue = Color(0xFF0000FF);
  static const Color darkBlueDuplicate = Color(0xFF00008B);
  static const Color lightSkyBlue = Color(0xFF87CEFA);
  static const Color grey = Color(0xFF959595);
  static const Color mediumBlue = Color(0xFF0000CD);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color fieldGrey = Color(0xFFE3E4E5);
  static const Color black = Color(0xFF000000);
}

class MainTheme {
  static Color primary = CustomColors.darkBlue;
  static Color background = CustomColors.white;

  static ThemeData lightTheme = ThemeData.light().copyWith(
    bottomAppBarTheme: BottomAppBarTheme(
      color: primary,
    ),
  );
}