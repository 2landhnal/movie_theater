import 'package:flutter/material.dart';
import 'package:movie_theater/pages/home/home_page_body.dart';
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
            onPressed: () =>
                SideSheet.right(body: const Text("Body"), context: context),
            icon: const Icon(
              Icons.list,
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
