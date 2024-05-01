import 'package:flutter/material.dart';
import 'package:movie_theater/pages/home/home_page.dart';
import 'package:movie_theater/pages/test/test_firebase.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestFirebase(),
    );
  }
}
