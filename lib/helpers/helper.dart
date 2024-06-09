import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/utils/asset.dart';

class MyHelper {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#\$%^&*()_+';
  static final Random _rnd = Random();

  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static String getSalt() => getRandomString(8);

  static Movie sampleMovie = Movie(
      id: 1,
      original_language: "",
      overview: "overview",
      release_date: getDateTimeFormat(DateTime.now()),
      poster_path: "/39wmItIWsg5sZMyRUHLkWBcuVCM.jpg",
      title: "Kungfu Panda 4",
      runtime: 128,
      vote_average: 8.0,
      streaming_state: "Streaming");
  static Schedule sampleSchedule = Schedule(
      movieId: "1",
      roomId: "1_1",
      date: "2024-05-27 00:10:38.325001",
      time: 1200,
      id: "id");
  static Theater sampleTheater = Theater(
      id: "1",
      name: "CGV Lieu Giai",
      added_at: getDateTimeFormat(DateTime.now()),
      loc: "11.2",
      lat: 110,
      lon: 110);
  static String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  static String hash(String s) {
    return sha256.convert(utf8.encode(s)).toString();
  }

  static String? validateNull(String? value) {
    return value == null || value.isEmpty ? 'This field is required' : null;
  }

  static String? passwordValidator(String? value) {
    if (value == null) return 'This field is required';
    if (value.isEmpty) return 'This field is required';
    if (value.length < 8) return 'Password required at least 8 character';
    return null;
  }

  static String? usernameValidator(String? value) {
    return value == null || value.isEmpty
        ? 'This field is required'
        : (value.contains(RegExp(r"_\/:=-"))
            ? "Username contain '_/:=-' is not allowed"
            : null);
  }

  static String getHourMinFromMin(int min) {
    return "${(min ~/ 60)} hour ${min % 60} min";
  }

  static String getTimeFromMin(int min) {
    min %= 1440;
    return "${(min ~/ 60) < 10 ? ("0${min ~/ 60}") : (min ~/ 60)}:${(min % 60) < 10 ? ("0${min % 60}") : (min % 60)}";
  }

  static String toUpper(String s) {
    return s.toUpperCase();
  }

  static String getDateTimeFormat(DateTime s) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(s);
    return formattedDate;
  }

  static String getDateInfoToMinute(DateTime date) {
    return "${DateFormat('EEEE').format(date)} ${DateFormat("MMMM").format(date)} ${date.day}, ${date.year} ${date.hour}:${date.minute}";
  }

  static String getDateInfo(DateTime date) {
    return "${DateFormat('EEEE').format(date)} ${DateFormat("MMMM").format(date)} ${date.day}, ${date.year}";
  }

  static String fromBillDateToDate(String s) {
    String account = s.split("_").first;
    String rawDate = s.substring(account.length + 1, s.length);
    return s.replaceAll("_", " ").replaceAll("?", ".");
  }

  static DateTime dateTimeToMinFromSchedule(Schedule schedule) {
    DateTime dt = DateTime.parse(schedule.date);
    int tmp = schedule.time;
    int hour = tmp ~/ 60;
    int min = tmp % 60;
    dt = DateTime(dt.year, dt.month, dt.day, hour, min);
    return dt;
  }

  static DateTime fromStringToDate(String s) {
    return GlobalUtils.globalDateFormat.parse(s);
  }
}
