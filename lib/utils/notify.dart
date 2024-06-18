import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyNotifier {
  static void ShowToast(String s) {
    Fluttertoast.showToast(
        msg: s,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        textColor: Colors.black,
        backgroundColor: Colors.white,
        fontSize: 16.0);
  }
}
