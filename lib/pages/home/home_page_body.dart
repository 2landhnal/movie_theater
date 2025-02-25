import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_theater/config/config_theme.dart';
import 'package:movie_theater/pages/home/widgets/home_page_movie_list.dart';
import 'package:movie_theater/pages/home/widgets/home_page_movie_title.dart';
import 'package:movie_theater/pages/home/widgets/home_page_near_theater.dart';
import 'package:movie_theater/pages/home/widgets/home_page_news_list.dart';
import 'package:movie_theater/pages/home/widgets/home_page_promo_list.dart';
import 'package:movie_theater/pages/home/widgets/home_page_row_header.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black38,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenSize.height / 6),
            const HomePagePromoList(),
            const SizedBox(height: 20),
            const HomePageMovieList(),
            const SizedBox(height: 10),
            const HomePageNearTheater(),
            const SizedBox(height: 10),
            Container(
              decoration: const BoxDecoration(color: Colors.grey),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        image: const DecorationImage(
                            image: NetworkImage(
                                "https://iguov8nhvyobj.vcdn.cloud/media/banner/cache/1/b58515f018eb873dafa430b6f9ae0c1e/2/0/2024_garfield_baby_rolling_banner.jpg"),
                            fit: BoxFit.cover),
                      ),
                      height: 150,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        3,
                        (index) => Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://iguov8nhvyobj.vcdn.cloud/media/banner/cache/1/b58515f018eb873dafa430b6f9ae0c1e/u/2/u22-240x201-04.png"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "CGV Store",
                              style: ThemeConfig.gettextStyle(),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(height: 10),
            const RowHeader(),
            const SizedBox(height: 10),
            const HomePageNewsList(),
          ],
        ),
      ),
    );
  }
}
