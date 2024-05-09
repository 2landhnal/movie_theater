import 'package:flutter/cupertino.dart';
import 'package:movie_theater/config/config_theme.dart';
import 'package:movie_theater/data/dataClasses.dart';

class MovieDetailTable extends StatelessWidget {
  MovieDetailTable({
    super.key,
    required this.movie,
    this.genreString = "",
    this.castString = "",
    this.directorString = "",
  });

  String genreString;
  String castString;
  String directorString;
  Movie movie;

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {0: FlexColumnWidth(3), 1: FlexColumnWidth(7)},
      children: [
        TableRow(children: [
          Text(
            "Rated",
            style: ThemeConfig.nearlyWhiteTextStyle(),
          ),
          Text(
            " T18 - MOVIES ARE ALLOWED TO BE DISSEMINATED TO VIEWERS AGED 18 YEARS AND OVER (18+)",
            style: ThemeConfig.nearlyWhiteTextStyle(fontsize: 12),
          ),
        ]),
        TableRow(children: [
          Text(
            "Genre",
            style: ThemeConfig.nearlyWhiteTextStyle(),
          ),
          Text(
            genreString,
            style: ThemeConfig.nearlyWhiteTextStyle(),
          ),
        ]),
        TableRow(children: [
          Text(
            "Language",
            style: ThemeConfig.nearlyWhiteTextStyle(),
          ),
          Text(
            movie.original_language,
            style: ThemeConfig.nearlyWhiteTextStyle(),
          ),
        ]),
        TableRow(children: [
          Text(
            "Director",
            style: ThemeConfig.nearlyWhiteTextStyle(),
          ),
          Text(
            directorString,
            style: ThemeConfig.nearlyWhiteTextStyle(),
          ),
        ]),
        TableRow(children: [
          Text(
            "Cast",
            style: ThemeConfig.nearlyWhiteTextStyle(),
          ),
          Text(
            castString,
            style: ThemeConfig.nearlyWhiteTextStyle(),
          ),
        ]),
      ],
    );
  }
}
