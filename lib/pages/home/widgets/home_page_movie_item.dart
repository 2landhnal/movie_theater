import 'package:flutter/material.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/pages/home/home_page_ctrl.dart';
import 'package:movie_theater/utils/asset.dart';
import 'package:provider/provider.dart';

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
        HomePageController.getInstance().navToMovieDetail(context, movie);
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
