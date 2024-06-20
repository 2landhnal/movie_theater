import 'package:flutter/material.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/pages/home/home_page_body.dart';
import 'package:movie_theater/pages/home/widgets/side_sheet_active_button.dart';
import 'package:movie_theater/pages/login/login_page.dart';
import 'package:movie_theater/pages/sign%20up/register_page.dart';
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
          width: screenSize.width / 7,
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
  SideSheetButton(
      {super.key,
      required this.buttonText,
      required this.func,
      this.vPad = 10});

  String buttonText;
  Function func;
  double vPad;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        func();
      },
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.white38),
          )),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: vPad),
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontSize: buttonText == "" ? 5 : 16,
            ),
          ),
        ),
      ),
    );
  }
}
