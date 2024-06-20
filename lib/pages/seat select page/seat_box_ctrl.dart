import 'package:movie_theater/pages/seat%20select%20page/seat_box.dart';

class SeatBoxController {
  SeatBox? _seatBox;
  SeatBoxController(SeatBox seatBox) {
    _seatBox = seatBox;
  }
  void seatBoxOnClick() {
    if (_seatBox!.ticket.ordered) return;
    _seatBox!.onClick(_seatBox!.ticket);
  }
}
