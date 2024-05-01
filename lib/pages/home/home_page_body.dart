import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_theater/config/config_theme.dart';
import 'package:movie_theater/pages/home/widgets/home_page_movie_list.dart';
import 'package:movie_theater/pages/home/widgets/home_page_movie_title.dart';
import 'package:movie_theater/pages/home/widgets/home_page_near_theater.dart';
import 'package:movie_theater/pages/home/widgets/home_page_news_list.dart';
import 'package:movie_theater/pages/home/widgets/home_page_promo_list.dart';

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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Streaming",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "Upcoming",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const HomePageMovieList(),
            const SizedBox(height: 10),
            const HomePageMovieTitle(),
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
                      ),
                      height: 150,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "CGV Store",
                            style: ThemeConfig.gettextStyle(),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "CGV Store",
                            style: ThemeConfig.gettextStyle(),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "CGV Store",
                            style: ThemeConfig.gettextStyle(),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hot News",
                    style: ThemeConfig.gettextStyle(
                      fontWeight: FontWeight.bold,
                      size: 12,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Colors.white, // your color here
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(20)))),
                      child: Text(
                        "All",
                        style: ThemeConfig.gettextStyle(
                          fontWeight: FontWeight.bold,
                          size: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const HomePageNewsList(),
          ],
        ),
      ),
    );
  }
}
