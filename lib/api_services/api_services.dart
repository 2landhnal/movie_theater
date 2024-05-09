import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/utils/asset.dart';

class APIService {
  static Future<List<Movie>?> getAllMovies() async {
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

  static Future<List<Movie_Genre>?> getMovieGenreList(int movieId) async {
    List<Movie_Genre> movieGenreList = [];
    var snapshot = await GlobalUtils.dbInstance
        .ref()
        .child('movie_genre')
        .child(movieId.toString())
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      for (var child in snapshot.children) {
        movieGenreList.add(Movie_Genre.fromMap(child.value as Map));
      }
      return movieGenreList;
    } else {
      print('No data available.');
    }
    return [];
  }

  static Future<List<Credit>?> getMovieCreditList(int movieId) async {
    List<Credit> movieCreditList = [];
    var snapshot = await GlobalUtils.dbInstance
        .ref()
        .child('credits')
        .child(movieId.toString())
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      for (var child in snapshot.children) {
        movieCreditList.add(Credit.fromMap(child.value as Map));
      }
      return movieCreditList;
    } else {
      print('No data available.');
    }
    return [];
  }

  static Future<Participant?> getParticipantByID(int id) async {
    var snapshot = await GlobalUtils.dbInstance
        .ref()
        .child('participants')
        .child(id.toString())
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      Participant result = Participant.fromMap(snapshot.value as Map);
      return result;
    } else {
      print('No data available.');
    }
    return null;
  }

  static Future<Genre?> getGenreByID(int id) async {
    var snapshot = await GlobalUtils.dbInstance
        .ref()
        .child('genres')
        .child(id.toString())
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      Genre result = Genre.fromMap(snapshot.value as Map);
      return result;
    } else {
      print('No data available.');
    }
    return null;
  }

  static Future<Account?> getUserByAccount(String account) async {
    var snapshot =
        await GlobalUtils.dbInstance.ref().child('users').child(account).get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      Account result = Account.fromMap(snapshot.value as Map);
      return result;
    } else {
      print('No data available.');
    }
    return null;
  }
}
