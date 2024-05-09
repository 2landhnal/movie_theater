import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:movie_theater/pages/home/home_page.dart';
import 'package:movie_theater/pages/home/home_page_body.dart';
import 'package:movie_theater/pages/login/login_page.dart';
import 'package:movie_theater/pages/movie%20detail/movie_detail_page.dart';
import 'package:movie_theater/pages/test/test_firebase.dart';
import 'package:movie_theater/pages/theater%20select/theater_select_page.dart';
import 'package:movie_theater/utils/asset.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  static bool loading = false;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkState();
  }

  Future _checkState() async {
    setState(() {
      MainApp.loading = true;
    });
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        _signIn();
      } else {
        print('User is signed in!');
        setState(() {
          GlobalUtils.dbInstance = FirebaseDatabase.instance;
          MainApp.loading = false;
        });
      }
    });
  }

  Future _signIn() async {
    var email = "nguyenhbyg9@gmail.com";
    var password = "19012003@";
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      setState(() {
        MainApp.loading = false;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GlobalUtils()..initLoginCheck(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Stack(children: [
          const HomePage(),
          Visibility(
            visible: MainApp.loading,
            child: const Center(
                child:
                    CircularProgressIndicator(backgroundColor: Colors.white38)),
          ),
        ]),
      ),
    );
  }
}
