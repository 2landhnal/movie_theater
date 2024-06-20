import 'package:flutter/material.dart';
import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/data/dataClasses.dart';

class MyTicketController {
  static List<Bill> fullBillList = [];
  static List<Bill> upComingList = [];
  static List<Bill> watchedList = [];
  static ValueNotifier<List<Bill>> billList = ValueNotifier([]);
  static Future getBillList() async {
    upComingList = [];
    watchedList = [];
    fullBillList = await APIService.getUserBills();
    for (var v in fullBillList) {
      DateTime dt = await APIService.getEndScheduleTimeByBill(v.id);
      if (dt.isAfter(DateTime.now())) {
        upComingList.add(v);
      } else {
        watchedList.add(v);
      }
    }
    billList.value = upComingList;
  }

  static void upcomingMode() {
    billList.value = upComingList;
  }

  static void watchedMode() {
    billList.value = watchedList;
  }
}
