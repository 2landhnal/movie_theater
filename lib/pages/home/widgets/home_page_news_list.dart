import 'package:flutter/material.dart';
import 'package:movie_theater/config/config_theme.dart';

class HomePageNewsList extends StatelessWidget {
  const HomePageNewsList({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.width * 0.4 * 2 / 2.5,
      child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          separatorBuilder: (context, index) => const SizedBox(
                width: 15,
              ),
          itemBuilder: (context, index) => NewsWidget(screenSize: screenSize)),
    );
  }
}

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: screenSize.width * 0.4,
          height: screenSize.width * 0.4 * 2 / 3.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
        ),
        Text(
          "News",
          style: ThemeConfig.gettextStyle(),
        )
      ],
    );
  }
}
