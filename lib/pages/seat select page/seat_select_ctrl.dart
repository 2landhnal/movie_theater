import 'package:flutter/material.dart';
import 'package:movie_theater/data/dataClasses.dart';

class SeatSelectController {
  static ValueNotifier<List<Ticket>> selectingTickets =
      ValueNotifier<List<Ticket>>([]);
  static void AddTicket(Ticket tic) {
    selectingTickets.value = List.from(selectingTickets.value)..add(tic);
  }

  static void RemoveTicket(Ticket tic) {
    selectingTickets.value = List.from(selectingTickets.value)
      ..removeWhere((element) => element.id == tic.id);
  }

  static void Click(Ticket tic) {
    if (List.from(selectingTickets.value).contains(tic)) {
      RemoveTicket(tic);
    } else {
      AddTicket(tic);
    }
  }
}
