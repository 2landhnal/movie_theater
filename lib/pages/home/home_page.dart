import 'package:flutter/material.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/pages/home/home_page_body.dart';
import 'package:movie_theater/pages/home/widgets/side_sheet_active_button.dart';
import 'package:movie_theater/pages/login/login_page.dart';
import 'package:movie_theater/pages/sign%20up/signup_page.dart';
import 'package:movie_theater/utils/asset.dart';
import 'package:provider/provider.dart';
import 'package:side_sheet/side_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Image.network(
          'https://demotimhecgv.goldena.vn/images/logo.png',
          fit: BoxFit.cover,
          width: screenSize.width / 6,
        ),
        actions: const [
          SideSheetActiveButton(),
          SizedBox(width: 20),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: const HomePageBody(),
    );
  }
}

class SideSheetButton extends StatelessWidget {
  SideSheetButton({
    super.key,
    required this.buttonText,
    required this.func,
  });

  String buttonText;
  Function func;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          func();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.white, // your color here
                width: 1,
              ),
              borderRadius: BorderRadius.circular(0))),
        ),
        child: Text(buttonText),
      ),
    );
  }
}
