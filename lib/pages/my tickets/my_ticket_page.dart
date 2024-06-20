import 'dart:ui';

import 'package:barcode_widget/barcode_widget.dart';
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
import 'package:movie_theater/pages/my%20tickets/my_ticket_ctrl.dart';
import 'package:movie_theater/pages/pay/pay_page.dart';
import 'package:movie_theater/utils/asset.dart';

class MyTicketsPage extends StatelessWidget {
  MyTicketsPage({super.key});

  ValueNotifier<bool> upcoming = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          toolbarHeight: MediaQuery.sizeOf(context).height / 8,
          //centerTitle: true,
          // title: Image.network(
          //   'https://demotimhecgv.goldena.vn/images/logo.png',
          //   fit: BoxFit.cover,
          //   width: screenSize.width / 6,
          // ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Column(
            children: [
              const Row(
                children: [
                  AppBarBackButton(),
                  Expanded(
                    child: Text(
                      "My tickets",
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: upcoming,
                builder: (context, value, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        MyTicketController.upcomingMode();
                        upcoming.value = true;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Upcoming ticket",
                          style: TextStyle(
                              color: upcoming.value
                                  ? Colors.white
                                  : Colors.white70,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        MyTicketController.watchedMode();
                        upcoming.value = false;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Watched ticket",
                          style: TextStyle(
                              color: upcoming.value
                                  ? Colors.white70
                                  : Colors.white,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: Container(
          constraints: const BoxConstraints(
            minHeight: double.infinity,
            minWidth: double.infinity,
          ),
          color: const Color.fromRGBO(0, 0, 0, 1),
          child: FutureBuilder(
              future: MyTicketController.getBillList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child:
                          CircularProgressIndicator()); // Hoặc bất kỳ Widget nào để hiển thị trạng thái chờ
                }
                if (snapshot.hasError) {
                  print("Error: ${snapshot.error}");
                  return Text(
                    'Error: ${snapshot.error}',
                  ); // Xử lý lỗi
                }
                return ValueListenableBuilder(
                  valueListenable: MyTicketController.billList,
                  builder: (context, value, child) => SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: List.generate(
                            MyTicketController.billList.value.length,
                            (index) => BillRow(
                                bill:
                                    MyTicketController.billList.value[index])),
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}

class BillRow extends StatelessWidget {
  BillRow({
    super.key,
    required this.bill,
  });
  Bill bill;
  ValueNotifier<bool> showDetail = ValueNotifier(false);
  Movie movie = MyHelper.sampleMovie;
  Schedule schedule = MyHelper.sampleSchedule;
  Theater theater = MyHelper.sampleTheater;
  List<Ticket> ticketList = [];
  double billPrice = 0;

  Future getInfo() async {
    schedule = await APIService.getScheduleByBill(bill.id) as Schedule;
    print("schedule");
    billPrice = await bill.getBillPrice();
    print("bill price");
    theater = await APIService.getTheaterById(schedule.roomId.split("_").first)
        as Theater;
    print("theater");
    movie = await APIService.getMovieById(schedule.movieId) as Movie;
    print("movie");
    ticketList = await APIService.getTicketListByBill(bill.id);
    print("ticketlist");
    //movie =
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    return FutureBuilder(
        future: getInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Hoặc bất kỳ Widget nào để hiển thị trạng thái chờ
          }
          if (snapshot.hasError) {
            print("Error: ${snapshot.error}");
            return Text(
              'Error: ${snapshot.error}',
            ); // Xử lý lỗi
          }
          return GestureDetector(
            onTap: () {
              showDetail.value = !showDetail.value;
            },
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.black,
                  border: Border(bottom: BorderSide(color: Colors.white))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          theater.name,
                          style: TextStyle(
                            color: ThemeConfig.nearlyWhiteColor,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          "${MyHelper.getDateInfo(MyHelper.fromStringToDate(schedule.date))} ${MyHelper.getTimeFromMin(schedule.time)}",
                          style: TextStyle(
                            color: ThemeConfig.nearlyWhiteColor,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          "Order at: ${MyHelper.getDateInfoToMinute(DateTime.parse(bill.date))}",
                          style: TextStyle(
                            color: ThemeConfig.nearlyWhiteColor,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "$billPrice\$",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        )
                      ],
                    ),
                    ValueListenableBuilder(
                      valueListenable: showDetail,
                      builder: (context, value, child) => Visibility(
                        visible: showDetail.value,
                        child: SizedBox(
                          width: screenSize.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BillDetailRow(
                                screenSize: screenSize,
                                schedule: schedule,
                                movie: movie,
                                theater: theater,
                                ticketList: ticketList,
                              ),
                              const SizedBox(height: 10),
                              BarcodeWidget(
                                backgroundColor: Colors.white,
                                width: screenSize.width * 0.8,
                                height: screenSize.width * 0.8 * 0.3,
                                barcode: Barcode.telepen(),
                                drawText: false,
                                data: 'Hello Flutter',
                                errorBuilder: (context, error) =>
                                    Center(child: Text(error)),
                              ),
                              const Text(
                                "Bring this barcode to CGV Store to get your ticket",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
    ();
  }
}
