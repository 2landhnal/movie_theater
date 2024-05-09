import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:movie_theater/config/config_theme.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/pages/home/widgets/appbar_back_button.dart';
import 'package:movie_theater/pages/home/widgets/side_sheet_active_button.dart';

class TheaterSelectPage extends StatefulWidget {
  TheaterSelectPage({
    super.key,
    required this.movie,
  });

  Movie movie;

  @override
  State<TheaterSelectPage> createState() => _TheaterSelectPageState();
}

class _TheaterSelectPageState extends State<TheaterSelectPage> {
  List<DateTime> dateList = [];

  DateTime _selectingDate = DateTime.now();

  void setSelectingDate(int index) {
    setState(() {
      _selectingDate = dateList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 7; i++) {
      dateList.add(_selectingDate.add(Duration(days: i)));
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
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
            Text(
              widget.movie.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: const [
          SideSheetActiveButton(),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
        color: Colors.black,
        constraints: BoxConstraints(
            minHeight: MediaQuery.sizeOf(context).height,
            minWidth: double.infinity),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height / 9),
            const TheaterSelectHeader(),
            TheaterSelectDatePicker(
              dateList: dateList,
              selectingDate: _selectingDate,
              onTap: setSelectingDate,
            ),
            Column(
              children: List.generate(10, (index) => const TheaterRow()),
            )
          ],
        ),
      )),
    );
  }
}

class TheaterRow extends StatefulWidget {
  const TheaterRow({
    super.key,
  });

  @override
  State<TheaterRow> createState() => _TheaterRowState();
}

class _TheaterRowState extends State<TheaterRow> {
  bool showSchedule = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showSchedule = !showSchedule;
        });
      },
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.black,
            border: Border(bottom: BorderSide(color: Colors.white))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "CGV AEON MALL",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ],
              ),
              Visibility(
                visible: showSchedule,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      20,
                      (index) => index % 2 == 0
                          ? const MovieTimePicker()
                          : const SizedBox(width: 5),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MovieTimePicker extends StatelessWidget {
  const MovieTimePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: ThemeConfig.nearlyWhiteColor,
          ),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5),
        child: Text("12:10",
            style:
                TextStyle(color: ThemeConfig.nearlyWhiteColor, fontSize: 12)),
      ),
    );
  }
}

class TheaterSelectDatePicker extends StatelessWidget {
  TheaterSelectDatePicker({
    super.key,
    required this.dateList,
    required this.selectingDate,
    required this.onTap,
  });

  List<DateTime> dateList;
  DateTime selectingDate;
  Function onTap;

  String getDateInfo(DateTime date) {
    return "${DateFormat('EEEE').format(date)} ${DateFormat("MMMM").format(date)} ${date.day}, ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 52, 52, 52)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                7,
                (index) => Column(
                  children: [
                    Text(
                      dateList[index].day.compareTo(DateTime.now().day) == 0
                          ? "Today"
                          : DateFormat('EE').format(dateList[index]),
                      style:
                          dateList[index].day.compareTo(DateTime.now().day) != 0
                              ? ThemeConfig.nearlyWhiteTextStyle()
                              : const TextStyle(color: Colors.red),
                    ),
                    GestureDetector(
                      onTap: () {
                        onTap(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: dateList[index]
                                      .day
                                      .compareTo(selectingDate.day) ==
                                  0
                              ? Colors.redAccent
                              : Colors.transparent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            (dateList[index].day.toString().length == 1
                                    ? "0"
                                    : "") +
                                dateList[index].day.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              getDateInfo(selectingDate),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TheaterSelectHeader extends StatelessWidget {
  const TheaterSelectHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black87),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Movie format",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  "All",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_right_outlined,
                  color: Colors.white70,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
