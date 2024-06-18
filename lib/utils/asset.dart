import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/pages/login/login_page.dart';
import 'package:movie_theater/pages/movie%20detail/movie_detail_page.dart';
import 'package:movie_theater/pages/sign%20up/signup_page.dart';
import 'package:movie_theater/utils/notify.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalUtils extends ChangeNotifier {
  static User? currentAccount;
  static Customer? currentCustomer;
  static MaterialColor purpleTextColor = Colors.deepPurple;
  static late List<Movie> currentMovieList;
  static DateFormat globalDateFormat = DateFormat('yyyy-MM-dd');
  void naviToLogin(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void movieDetail(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MovieDetail(movie: movie)),
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

  Future<List<Movie>> getMovieByStreamingState(String state) async {
    List<Movie> movies = await APIService.getAllMovies() as List<Movie>;
    movies =
        movies.where((element) => element.streaming_state == state).toList();
    return movies;
  }

  void signUpFunc(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }

  Future<void> logOutFunc(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    currentAccount = null;
    currentCustomer = null;
    Navigator.pop(context);
    notifyListeners();
    MyNotifier.ShowToast("Log out succeess!");
  }

  static Future checkState() async {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future<void> initLoginCheck() async {
    await checkState();
  }

  void loginAccount(User? acc, Customer? cus, BuildContext context) {
    currentAccount = acc;
    currentCustomer = cus;
    notifyListeners();
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(GlobalUtils.createSnackBar(context, "Success!!"));
  }

  InputDecoration inputDecorationBlack({
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
