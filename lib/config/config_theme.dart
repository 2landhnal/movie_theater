import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyConfig {
  static var acs = ActionCodeSettings(
      // URL you want to redirect back to. The domain (www.example.com) for this
      // URL must be whitelisted in the Firebase Console.
      url: 'https://www.google.com',
      // This must be true
      handleCodeInApp: true,
      iOSBundleId: 'com.example.movie_theater',
      androidPackageName: 'com.example.movie_theater',
      // installIfNotAvailable
      androidInstallApp: true,
      // minimumVersion
      androidMinimumVersion: '12');
}

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
