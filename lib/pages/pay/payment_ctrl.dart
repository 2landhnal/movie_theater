import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/pages/login/login_ctrl.dart';

class PaymentController {
  static List<PaymentMethod> paymentMethodList = [];

  static final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);
  static Future<List<PaymentMethod>> loadAllPayMethod() async {
    List<PaymentMethod> payMethods = [];
    var snapshot =
        await FirebaseDatabase.instance.ref().child('payment_methods').get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return [];
      for (var child in snapshot.children) {
        payMethods.add(PaymentMethod.fromMap(child.value as Map));
      }
      print("DONE!!");
      paymentMethodList = payMethods;
      return payMethods;
    } else {
      print('No data available.');
    }
    return [];
  }

  static Future<void> addBillInfo(
      PaymentMethod paymentMethod, List<Ticket> ticketList) async {
    Bill newBill = Bill(
      userId: LoginController.currentAccount!.uid,
      date: DateTime.now().toString(),
      voucherId: "null",
      paymentMethodId: paymentMethod.id,
    );
    print("newBill.id: ${newBill.id}");
    BillDetail tmpBillDetail;
    for (var i in ticketList) {
      i.ordered = true;
      await APIService.pushToFireBase("tickets/${i.id}/", i.toMap());
      tmpBillDetail = BillDetail(productId: i.id, billId: newBill.id);
      await APIService.pushToFireBase(
          "bill_details/${tmpBillDetail.id}/", tmpBillDetail.toMap());
    }
    await APIService.pushToFireBase("bills/${newBill.id}/", newBill.toMap());
  }
}
