import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:movie_theater/utils/asset.dart';

class MyHelper {
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

  static String getDateInfo(DateTime date) {
    return "${DateFormat('EEEE').format(date)} ${DateFormat("MMMM").format(date)} ${date.day}, ${date.year}";
  }

  static DateTime fromStringToDate(String s) {
    return GlobalUtils.globalDateFormat.parse(s);
  }
}
