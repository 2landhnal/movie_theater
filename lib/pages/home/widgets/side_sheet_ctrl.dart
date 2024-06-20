import 'package:flutter/material.dart';
import 'package:movie_theater/pages/login/login_ctrl.dart';
import 'package:movie_theater/pages/my%20tickets/my_ticket_page.dart';
import 'package:movie_theater/utils/asset.dart';
import 'package:provider/provider.dart';

class SideSheetController {
  static void myTicketsOnClick(BuildContext context) {
    if (LoginController.currentAccount == null) {
      GlobalUtils.navToLogin(context);
      return;
    }
    GlobalUtils.navToMyTicket(context);
  }
}
