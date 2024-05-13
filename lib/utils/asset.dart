import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/pages/login/login_page.dart';
import 'package:movie_theater/pages/movie%20detail/movie_detail_page.dart';
import 'package:movie_theater/pages/sign%20up/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalUtils extends ChangeNotifier {
  Account? currentAccount;
  static late FirebaseDatabase dbInstance;
  static late SharedPreferences sharedPrefs;
  static MaterialColor purpleTextColor = Colors.deepPurple;
  static late List<Movie> currentMovieList;
  static DateFormat globalDateFormat = DateFormat('yyyy-MM-dd');
  void loginFunc(BuildContext context) {
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

  static SnackBar createSnackBar(BuildContext context, String message) {
    return SnackBar(
      content: Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          right: 20,
          left: 20),
    );
  }

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

  void logOutFunc(BuildContext context) {
    sharedPrefs.remove("username");
    currentAccount = null;
    Navigator.pop(context);
    notifyListeners();
  }

  static Future checkState() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        _signIn();
      } else {
        print('User is signed in!');
        GlobalUtils.dbInstance = FirebaseDatabase.instance;
      }
    });
  }

  static Future _signIn() async {
    var email = "nguyenhbyg9@gmail.com";
    var password = "19012003@";
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      GlobalUtils.dbInstance = FirebaseDatabase.instance;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> initLoginCheck() async {
    await checkState();
    sharedPrefs = await SharedPreferences.getInstance();
    notifyListeners();
    String? username = sharedPrefs.getString('username');
    if (username != null) {
      Account? acc = await APIService.getUserByAccount(username);
      if (acc != null) {
        currentAccount = acc;
        notifyListeners();
      } else {
        print("ACC NULL");
      }
    } else {
      print("USERNAME NULL");
    }
  }

  void loginAccount(Account acc) {
    currentAccount = acc;
    notifyListeners();
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
