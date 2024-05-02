import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:movie_theater/pages/login/login_page.dart';
import 'package:movie_theater/pages/sign%20up/signup_page.dart';

class GlobalUtils {
  static late FirebaseDatabase dbInstance;
  static MaterialColor purpleTextColor = Colors.deepPurple;
  static void loginFunc(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  static void signUpFunc(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }

  static InputDecoration inputDecorationBlack({
    String labelText = "Label",
    TextStyle labelStyle = const TextStyle(color: Colors.white),
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.transparent,
      border: const OutlineInputBorder(),
      labelText: labelText,
      labelStyle: labelStyle,
    );
  }
}
