import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/pages/home/home_page_ctrl.dart';
import 'package:movie_theater/pages/home/widgets/home_page_movie_title.dart';
import 'package:movie_theater/pages/home/widgets/home_page_movie_item.dart';
import 'package:movie_theater/utils/asset.dart';
import 'package:provider/provider.dart';

class HomePageMovieList extends StatefulWidget {
  const HomePageMovieList({super.key});

  @override
  State<HomePageMovieList> createState() => _HomePageMovieListState();
}

class _HomePageMovieListState extends State<HomePageMovieList> {
  late Future parentFutureFunc;
  bool streaming = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parentFutureFunc =
        HomePageController.getInstance().getMovieByStreamingState("Streaming");
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double padding = 20;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  streaming = true;
                  parentFutureFunc = HomePageController.getInstance()
                      .getMovieByStreamingState("Streaming");
                });
              },
              child: Text(
                "Streaming",
                style: TextStyle(
                    color: streaming ? Colors.white : Colors.white54,
                    fontWeight:
                        !streaming ? FontWeight.normal : FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  streaming = false;
                  parentFutureFunc = HomePageController.getInstance()
                      .getMovieByStreamingState("Upcoming");
                });
              },
              child: Text(
                "Upcoming",
                style: TextStyle(
                    color: !streaming ? Colors.white : Colors.white54,
                    fontWeight:
                        streaming ? FontWeight.normal : FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        MovieList(
            size: screenSize,
            padding: padding,
            futureFunction: parentFutureFunc),
      ],
    );
  }
}

class MovieList extends StatefulWidget {
  MovieList(
      {super.key,
      required this.size,
      required this.padding,
      required this.futureFunction});

  Size size;
  final double padding;
  Future futureFunction;

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  double widthRate = 0.7;
  int initPage = 100;
  int currentIndex = 100;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.futureFunction,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Hoặc bất kỳ Widget nào để hiển thị trạng thái chờ
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Xử lý lỗi
        }

        List<Movie> movies = snapshot.data as List<Movie>;

        return Column(
          children: [
            Container(
              height: widget.size.width * widthRate * 3 / 2,
              decoration: const BoxDecoration(color: Colors.white),
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                controller: PageController(
                    viewportFraction: widthRate, initialPage: initPage),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => MovieItem(
                  movie: movies[index % movies.length],
                  height: widget.size.width * widthRate * 3 / 2,
                  padding: widget.padding,
                ),
              ),
            ),
            const SizedBox(height: 10),
            HomePageMovieTitle(movie: movies[currentIndex % movies.length]),
          ],
        );
      },
    );
  }
}
