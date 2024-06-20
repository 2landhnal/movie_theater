import 'package:flutter/material.dart';
import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/pages/movie%20detail/movie_detail_ctrl.dart';
import 'package:movie_theater/pages/movie%20detail/movie_detail_page.dart';

class HomePageController {
  static HomePageController? _instance;
  static HomePageController getInstance() {
    _instance ??= HomePageController();
    return _instance!;
  }

  Future<List<Movie>> getMovieByStreamingState(String state) async {
    List<Movie> movies = await APIService.getAllMovies() as List<Movie>;
    movies =
        movies.where((element) => element.streaming_state == state).toList();
    return movies;
  }

  void navToMovieDetail(BuildContext context, Movie movie) {
    MovieDetailController.movie = movie;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MovieDetail()),
    );
  }
}
