import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePageMovieList extends StatelessWidget {
  const HomePageMovieList({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.width * 0.5 * 5 / 3;
    double padding = 20;

    return Container(
      height: height,
      decoration: const BoxDecoration(color: Colors.white),
      child: ListView.separated(
        padding: EdgeInsets.all(padding),
        separatorBuilder: (context, index) => const SizedBox(width: 15),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => MovieItem(
          height: height,
          padding: padding,
        ),
      ),
    );
  }
}

class MovieItem extends StatelessWidget {
  const MovieItem({
    super.key,
    required this.height,
    required this.padding,
  });

  final double height;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (height - padding * 2) * 2 / 3,
      decoration: BoxDecoration(
        image: const DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              "https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg",
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
    );
  }
}
