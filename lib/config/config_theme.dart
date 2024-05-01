import 'package:flutter/material.dart';

class ThemeConfig {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.white,
        )),
  );
  static TextStyle gettextStyle(
      {double size = 12, FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      fontWeight: fontWeight,
      color: Colors.white,
      fontSize: size,
    );
  }
}
