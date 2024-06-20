import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/pages/login/login_page.dart';
import 'package:movie_theater/pages/movie%20detail/movie_detail_ctrl.dart';
import 'package:movie_theater/pages/movie%20detail/movie_detail_page.dart';
import 'package:movie_theater/pages/my%20tickets/my_ticket_page.dart';
import 'package:movie_theater/pages/sign%20up/register_page.dart';
import 'package:movie_theater/pages/theater%20select/theater_select_ctrl.dart';
import 'package:movie_theater/pages/theater%20select/theater_select_page.dart';
import 'package:movie_theater/utils/notify.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalUtils {
  static MaterialColor purpleTextColor = Colors.deepPurple;
  static DateFormat globalDateFormat = DateFormat('yyyy-MM-dd');
  static void navToLogin(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  static void navToMyTicket(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyTicketsPage()),
    );
  }

  static void navToTheaterSelect(BuildContext context, Movie movie) {
    TheaterSelectController.movie = movie;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TheaterSelectPage()),
    );
  }

  // static SnackBar createSnackBar(BuildContext context, String message) {
  //   return SnackBar(
  //     content: Center(
  //       child: Text(
  //         message,
  //         style: const TextStyle(color: Colors.black),
  //       ),
  //     ),
  //     behavior: SnackBarBehavior.floating,
  //     backgroundColor: Colors.white,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(24),
  //     ),
  //     margin: EdgeInsets.only(
  //         bottom: MediaQuery.of(context).size.height - 100,
  //         right: 20,
  //         left: 20),
  //   );
  // }

  static void navToSignUpPage(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
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
