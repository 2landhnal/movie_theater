import 'package:firebase_database/firebase_database.dart';
import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/helpers/helper.dart';

class TheaterSelectController {
  static Movie? movie;

  static Future<List<Schedule>> getCurrentSchedule(
      DateTime selectingDate) async {
    var tmp = (await getScheduleListByDateAndMovie(
        MyHelper.getDateTimeFormat(selectingDate),
        TheaterSelectController.movie!.id.toString()))!;
    tmp = tmp
        .where((element) =>
            MyHelper.dateTimeToMinFromSchedule(element).isAfter(DateTime.now()))
        .toList();
    tmp.sort((a, b) => a.time - b.time);
    return tmp;
  }

  static Future<List<Theater>> getCurrentTheaterList(
      List<Schedule> currentScheduleList) async {
    List<Theater> tmpTheaterList = [];
    var theaterIdSet = <String>{};
    for (int i = 0; i < currentScheduleList.length; i++) {
      theaterIdSet.add(currentScheduleList[i].roomId.split("_")[0]);
    }
    for (var id in theaterIdSet) {
      Theater? newTheater = await APIService.getTheaterById(id);
      tmpTheaterList.add(newTheater!);
    }
    return tmpTheaterList;
  }

  static Future<List<Schedule>?> getScheduleListByDateAndMovie(
      String date, String movieId) async {
    List<Schedule> scheduleList = [];
    var snapshot = await FirebaseDatabase.instance
        .ref()
        .child('schedules')
        .orderByChild("date")
        .equalTo(date)
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      for (var child in snapshot.children) {
        var tmp = Schedule.fromMap(child.value as Map);
        if (tmp.movieId == movieId) scheduleList.add(tmp);
      }
      return scheduleList;
    } else {
      print('No data available.');
    }
    return [];
  }

  static Future<List<Schedule>?> getScheduleListByDateAndMovieAndTheater(
      String date, String movieId, String theaterId) async {
    List<Schedule> scheduleList = [];
    var snapshot = await FirebaseDatabase.instance
        .ref()
        .child('schedules')
        .orderByChild("date")
        .equalTo(date)
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      for (var child in snapshot.children) {
        var tmp = Schedule.fromMap(child.value as Map);
        if (tmp.movieId == movieId && tmp.roomId.split("_")[0] == theaterId) {
          scheduleList.add(tmp);
        }
      }
      return scheduleList;
    } else {
      print('No data available.');
    }
    return [];
  }
}
