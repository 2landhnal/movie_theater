import 'package:flutter/material.dart';
import 'package:movie_theater/data/dataClasses.dart';

class SeatBox extends StatefulWidget {
  SeatBox({
    super.key,
    required this.ticket,
    required this.seat,
    required this.index,
    required this.onClick,
  });

  final Ticket ticket;
  final Room_Seat seat;
  final int index;
  Function onClick;

  @override
  State<SeatBox> createState() => _SeatBoxState();
}

class _SeatBoxState extends State<SeatBox> {
  bool selected = false;
  Color selectedColor = const Color.fromARGB(255, 163, 0, 0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.ticket.ordered) return;
        widget.onClick(widget.ticket);
        setState(() {
          selected = !selected;
        });
      },
      child: Container(
        color: widget.ticket.ordered == false
            ? (selected
                ? selectedColor
                : (widget.seat.seatType == 2
                    ? Colors.red
                    : const Color.fromARGB(255, 206, 192, 191)))
            : Colors.black,
        child: Center(
            child: Text(
          widget.seat.name,
          style: const TextStyle(fontSize: 8),
        )),
      ),
    );
  }
}
