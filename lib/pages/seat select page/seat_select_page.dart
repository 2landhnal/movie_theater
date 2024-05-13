import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/config/config_theme.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/helpers/helper.dart';
import 'package:movie_theater/pages/home/widgets/appbar_back_button.dart';
import 'package:movie_theater/pages/home/widgets/side_sheet_active_button.dart';

class SeatSelectPage extends StatelessWidget {
  SeatSelectPage({super.key});

  Map<String, List<int>> seatMap = <String, List<int>>{};

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: APIService.getRoomSeatList("0_4"),
      initialData: null,
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
            style: ThemeConfig.nearlyWhiteTextStyle(),
          ); // Xử lý lỗi
        }
        List<Room_Seat> result = snapshot.data as List<Room_Seat>;
        List<Room_Seat> seats = [];
        int maxCol = 0;
        int maxRow = 0;
        for (int i = 0; i < result.length; i++) {
          String firstLeter = result[i].id[0];
          int index = int.parse(result[i].id.substring(1));
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
            seats.add(result
                .firstWhere((element) => element.id == key + value.toString()));
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
        print(maxRow);
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
            title: const Row(
              children: [
                AppBarBackButton(),
                Text(
                  "Seat select",
                  style: TextStyle(
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
                                  child: Container(
                                    color: seats[index].seatType == 2
                                        ? Colors.red
                                        : const Color.fromARGB(
                                            255, 206, 192, 191),
                                    child: Center(
                                        child: Text(
                                      seats[index].id,
                                      style: const TextStyle(fontSize: 8),
                                    )),
                                  ),
                                )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            height: MediaQuery.sizeOf(context).height / 10,
            color: Colors.black,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      MyHelper.toUpper("Dune 2"),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      "2D English Sub | Golden Class ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      "0\$",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
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
          ),
        );
      },
    );
  }
}
