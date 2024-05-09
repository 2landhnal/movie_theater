import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/pages/home/widgets/home_page_movie_title.dart';
import 'package:movie_theater/utils/asset.dart';
import 'package:provider/provider.dart';

class HomePageMovieList extends StatefulWidget {
  const HomePageMovieList({super.key});

  @override
  State<HomePageMovieList> createState() => _HomePageMovieListState();
}

class _HomePageMovieListState extends State<HomePageMovieList> {
  late Future parentFutureFunc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parentFutureFunc =
        context.read<GlobalUtils>().getMovieByStreamingState("Streaming");
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
                  parentFutureFunc = context
                      .read<GlobalUtils>()
                      .getMovieByStreamingState("Streaming");
                });
              },
              child: const Text(
                "Streaming",
                style: TextStyle(color: Colors.white),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  parentFutureFunc = context
                      .read<GlobalUtils>()
                      .getMovieByStreamingState("Upcoming");
                });
              },
              child: const Text(
                "Upcoming",
                style: TextStyle(color: Colors.white),
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

class MovieItem extends StatelessWidget {
  MovieItem({
    super.key,
    required this.height,
    required this.padding,
    required this.movie,
  });

  final double height;
  final double padding;
  Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Clicked");
        context.read<GlobalUtils>().movieDetail(context, movie);
      },
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Container(
          width: (height - padding * 2) * 2 / 3,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  //"https://image.tmdb.org/t/p/w500/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg"
                  movie.getPosterFullPath(),
                )),
            //color: Colors.amber,
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 5), // changes position of shadow
              ),
            ],
          ),
        ),
      ),
    );
  }
}
