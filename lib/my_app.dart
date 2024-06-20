import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:movie_theater/helpers/helper.dart';
import 'package:movie_theater/pages/home/home_page.dart';
import 'package:movie_theater/pages/home/home_page_body.dart';
import 'package:movie_theater/pages/login/login_ctrl.dart';
import 'package:movie_theater/pages/login/login_page.dart';
import 'package:movie_theater/pages/movie%20detail/movie_detail_page.dart';
import 'package:movie_theater/pages/my%20tickets/my_ticket_page.dart';
import 'package:movie_theater/pages/pay/pay_page.dart';
import 'package:movie_theater/pages/seat%20select%20page/seat_select_page.dart';
import 'package:movie_theater/pages/test/test_firebase.dart';
import 'package:movie_theater/pages/test/test_push.dart';
import 'package:movie_theater/pages/theater%20select/theater_select_page.dart';
import 'package:movie_theater/utils/asset.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LoginController.checkState(),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child:
                  CircularProgressIndicator()); // Hoặc bất kỳ Widget nào để hiển thị trạng thái chờ
        }
        if (snapshot.hasError) {
          print("Error: ${snapshot.error}");
          return Text('Error: ${snapshot.error}'); // Xử lý lỗi
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        );
      },
    );
  }
}
