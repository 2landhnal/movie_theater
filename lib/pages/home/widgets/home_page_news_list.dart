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
            image: const DecorationImage(
                image: NetworkImage(
                    "https://media.vanityfair.com/photos/65bc53b6dbcc8f7a911121f8/master/pass/DUN2-T3-0084r.jpg"),
                fit: BoxFit.cover),
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
