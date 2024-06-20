import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/config/config_theme.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/helpers/helper.dart';
import 'package:movie_theater/pages/home/widgets/appbar_back_button.dart';
import 'package:movie_theater/pages/home/widgets/side_sheet_active_button.dart';
import 'package:movie_theater/pages/login/login_ctrl.dart';
import 'package:movie_theater/pages/login/login_page.dart';
import 'package:movie_theater/pages/pay/pay_page.dart';
import 'package:movie_theater/pages/seat%20select%20page/seat_select_ctrl.dart';
import 'package:movie_theater/utils/asset.dart';

import 'seat_box.dart';

class SeatSelectPage extends StatelessWidget {
  SeatSelectPage({super.key, required this.schedule, required this.theater});
  Schedule schedule;
  Theater theater;

  Map<String, List<int>> seatMap = <String, List<int>>{};

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
        [
          APIService.getRoomSeatList(schedule.roomId),
          APIService.getMovieById(schedule.movieId),
          APIService.getTicketListBySchedule(schedule.id)
        ],
      ),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child:
                  CircularProgressIndicator()); // Hoặc bất kỳ Widget nào để hiển thị trạng thái chờ
        }
        if (snapshot.hasError) {
          print("Error: ${snapshot.error}");
          return Text(
            'Error: ${snapshot.error}',
            style: ThemeConfig.nearlyWhiteTextStyle(),
          ); // Xử lý lỗi
        }
        List<Room_Seat> result = snapshot.data![0] as List<Room_Seat>;
        List<Ticket> tickets = snapshot.data![2] as List<Ticket>;
        List<Room_Seat> seats = [];
        Map<String, Ticket> ticketMap = {};

        for (var i in tickets) {
          ticketMap[i.seatId] = i;
        }

        int maxCol = 0;
        int maxRow = 0;
        Movie movie = snapshot.data![1];
        for (int i = 0; i < result.length; i++) {
          String firstLeter = result[i].name[0];
          int index = int.parse(result[i].name.substring(1));
          if (seatMap[firstLeter] == null) {
            seatMap[firstLeter] = [];
          }
          seatMap[firstLeter]!.add(index);
          maxCol = max(maxCol, seatMap[firstLeter]!.length);
        }
        for (var key in seatMap.keys) {
          seatMap[key]!.sort();
        }
        for (var key in seatMap.keys) {
          for (int value in seatMap[key]!) {
            seats.add(result.firstWhere(
                (element) => element.name == key + value.toString()));
          }
          maxRow += 1;
        }
        double hPadding = 100;
        double vPadding = 50;
        double seatSecHeight =
            MediaQuery.sizeOf(context).width * 0.08 * maxRow +
                1 * (maxRow - 1) +
                vPadding * 2;
        double seatSecWidth = MediaQuery.sizeOf(context).width * 0.08 * maxCol +
            1 * (maxCol - 1) +
            hPadding * 2;
        return Scaffold(
          appBar: AppBar(
            //centerTitle: true,
            // title: Image.network(
            //   'https://demotimhecgv.goldena.vn/images/logo.png',
            //   fit: BoxFit.cover,
            //   width: screenSize.width / 6,
            // ),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            title: Row(
              children: [
                const AppBarBackButton(),
                Expanded(
                  child: Text(
                    movie.title,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            actions: const [
              SideSheetActiveButton(),
              SizedBox(width: 20),
            ],
          ),
          body: Container(
            color: const Color.fromARGB(255, 27, 27, 27),
            height: MediaQuery.sizeOf(context).height,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                //color: Colors.amber,
                width: seatSecWidth,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        "SCREEN",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        padding: EdgeInsets.symmetric(
                            vertical: vPadding, horizontal: hPadding),
                        crossAxisCount: maxCol,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        children: List.generate(
                            seats.length,
                            (index) => Visibility(
                                  visible: seats[index].seatType != 0,
                                  child: SeatBox(
                                    ticket: ticketMap[seats[index].id]!,
                                    seat: seats[index],
                                    index: index,
                                    onClick: SeatSelectController.Click,
                                  ),
                                )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: SeatSelectBottom(
            movie: movie,
            selectingTickets: SeatSelectController.selectingTickets,
            schedule: schedule,
            theater: theater,
          ),
        );
      },
    );
  }
}

class SeatSelectBottom extends StatefulWidget {
  const SeatSelectBottom({
    super.key,
    required this.movie,
    required this.selectingTickets,
    required this.schedule,
    required this.theater,
  });

  final Movie movie;
  final Schedule schedule;
  final Theater theater;
  final ValueNotifier<List<Ticket>> selectingTickets;

  @override
  State<SeatSelectBottom> createState() => _SeatSelectBottomState();
}

class _SeatSelectBottomState extends State<SeatSelectBottom> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Ticket>>(
        valueListenable: widget.selectingTickets,
        builder: (context, value, child) {
          return BottomAppBar(
            height: MediaQuery.sizeOf(context).height / 10,
            color: Colors.black,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        MyHelper.toUpper(widget.movie.title),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        "2D English Sub | Golden Class",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${widget.selectingTickets.value.isEmpty ? 0 : widget.selectingTickets.value.map((ticket) => ticket.getPrice()).reduce((a, b) => a + b)}\$",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (LoginController.currentAccount == null) {
                      //Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                      return;
                    }
                    if (widget.selectingTickets.value.isEmpty) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PayPage(
                                movie: widget.movie,
                                schedule: widget.schedule,
                                theater: widget.theater,
                                ticketList: widget.selectingTickets.value,
                              )),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text("Book"),
                ),
                //add as many tabs as you want here
              ],
            ),
          );
        });
  }
}
