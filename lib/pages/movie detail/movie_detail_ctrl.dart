import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/data/dataClasses.dart';

class MovieDetailController {
  static Movie? movie;
  static String castString = "";
  static String directorString = "";
  static String genreString = "";

  static Future getInforFunc() async {
    genreString = await MovieDetailController.getGenreOutput();
    castString = await MovieDetailController.getCastOutput();
    directorString = await MovieDetailController.getDirectorOutput();
  }

  static Future<String> getGenreOutput() async {
    String s = "";
    List<String> genreList = [];
    List<Movie_Genre>? movieGenreList =
        await APIService.getMovieGenreList(movie!.id);
    for (int i = 0; i < movieGenreList!.length; i++) {
      Genre? genre = await APIService.getGenreByID(movieGenreList[i].genreId);
      genreList.add(genre!.name);
    }
    s = genreList.join(", ");
    return s;
  }

  static Future<String> getDirectorOutput() async {
    String s = "";
    List<String> directorList = [];
    List<Credit>? creditList = await APIService.getMovieCreditList(movie!.id);
    for (int i = 0; i < creditList!.length; i++) {
      if (directorList.length >= 3) {
        break;
      }
      if (creditList[i].departmentID == 0 && directorList.length < 3) {
        Participant? participant =
            await APIService.getParticipantByID(creditList[i].particapantID);
        directorList.add(participant!.name);
      }
    }
    s = directorList.join(", ");
    return s;
  }

  static Future<String> getCastOutput() async {
    String s = "";
    List<String> castList = [];
    List<Credit>? creditList = await APIService.getMovieCreditList(movie!.id);
    for (int i = 0; i < creditList!.length; i++) {
      if (castList.length >= 5) {
        break;
      }
      if (creditList[i].departmentID == 1 && castList.length < 5) {
        Participant? participant =
            await APIService.getParticipantByID(creditList[i].particapantID);
        if (participant != null) {
          castList.add(participant.name); // Use `!` if sure it's not null.
        }
      }
    }
    s = castList.join(", ");
    return s;
  }
}
