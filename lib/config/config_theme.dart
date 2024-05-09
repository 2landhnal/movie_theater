import 'package:flutter/material.dart';

class ThemeConfig {
  static Color nearlyWhiteColor = const Color.fromARGB(255, 196, 196, 196);
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

  static TextStyle nearlyWhiteTextStyle(
      {double fontsize = 14, FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      color: const Color.fromARGB(255, 196, 196, 196),
      fontSize: fontsize,
      fontWeight: fontWeight,
    );
  }
}
