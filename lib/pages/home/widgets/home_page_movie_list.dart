import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/utils/asset.dart';

class HomePageMovieList extends StatelessWidget {
  const HomePageMovieList({super.key});

  Future<List<Movie>?> getListMovie() async {
    List<Movie> movies = [];
    var snapshot = await GlobalUtils.dbInstance.ref().child('movies').get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      for (var child in snapshot.children) {
        movies.add(Movie.fromMap(child.value as Map));
      }
      print("DONE!!");
      return movies;
    } else {
      print('No data available.');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.width * 0.5 * 5 / 3;
    double padding = 20;

    return FutureBuilder(
      future: getListMovie(),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Hoặc bất kỳ Widget nào để hiển thị trạng thái chờ
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Xử lý lỗi
        }

        List<Movie> movies = (snapshot.data as List<Movie>)
            .where((element) => element.streaming_state == "Streaming")
            .toList();
        print(movies.length);
        return Container(
          height: height,
          decoration: const BoxDecoration(color: Colors.white),
          child: ListView.separated(
            padding: EdgeInsets.all(padding),
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            itemCount: movies.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => MovieItem(
              movie: movies[index],
              height: height,
              padding: padding,
            ),
          ),
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
    return Container(
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
    );
  }
}
