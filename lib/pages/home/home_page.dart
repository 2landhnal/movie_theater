import 'package:flutter/material.dart';
import 'package:movie_theater/pages/home/home_page_body.dart';
import 'package:movie_theater/pages/login/login_page.dart';
import 'package:movie_theater/pages/sign%20up/signup_page.dart';
import 'package:movie_theater/utils/asset.dart';
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
        actions: [
          IconButton(
            onPressed: () => SideSheet.right(
                body: Container(
                  decoration: const BoxDecoration(color: Colors.black38),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      const SizedBox(height: 30),
                      const CircleAvatar(
                        radius: 48, // Image radius
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2LXLcFC4dITo9xY44-DbI3cttjeDtK61duaeV2199tg&s'),
                      ),
                      const Text("username"),
                      SideSheetButton(
                        buttonText: "Sign In",
                        func: () => GlobalUtils.loginFunc(context),
                      ),
                      SideSheetButton(
                          buttonText: "Sign Up",
                          func: () => GlobalUtils.signUpFunc(context)),
                    ],
                  ),
                ),
                context: context),
            icon: const Icon(
              Icons.view_list_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 20),
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
