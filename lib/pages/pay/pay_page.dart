import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_theater/api_services/api_services.dart';
import 'package:movie_theater/config/config_theme.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/helpers/helper.dart';
import 'package:movie_theater/pages/home/widgets/appbar_back_button.dart';
import 'package:movie_theater/pages/home/widgets/side_sheet_active_button.dart';
import 'package:movie_theater/pages/movie%20detail/movie_detail_page.dart';
import 'package:movie_theater/pages/pay/widget/bordered_text.dart';
import 'package:movie_theater/pages/pay/widget/full_screen_circular_progress.dart';
import 'package:movie_theater/utils/asset.dart';

class PayPage extends StatelessWidget {
  PayPage(
      {super.key,
      required this.movie,
      required this.schedule,
      required this.theater,
      required this.ticketList});

  Movie movie;
  Schedule schedule;

  Theater theater;
  List<Ticket> ticketList;
  List<PaymentMethod> paymentMethodList = [];

  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  final ValueNotifier<bool> _loading = ValueNotifier<bool>(false);

  Future getPaymentMethod() async {
    paymentMethodList = await APIService.getAllPayMethod();
  }

  final TextEditingController _voucheController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          toolbarHeight: screenSize.height / 3.5,
          //centerTitle: true,
          // title: Image.network(
          //   'https://demotimhecgv.goldena.vn/images/logo.png',
          //   fit: BoxFit.cover,
          //   width: screenSize.width / 6,
          // ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: PaymentPageAppBarBody(
              screenSize: screenSize,
              movie: movie,
              schedule: schedule,
              theater: theater,
              ticketList: ticketList),
        ),
        body: Container(
          color: const Color.fromARGB(255, 27, 27, 27),
          height: MediaQuery.sizeOf(context).height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    "Summary".toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                HeaderRow(
                  header: "Total",
                  value:
                      "${ticketList.map((ticket) => ticket.getPrice()).reduce((a, b) => a + b)}",
                ),
                HeaderRow(
                  header: "Discount",
                  value: "000",
                ),
                HeaderRow(
                  header: "CGV Giftcard/eGift",
                  value: "000",
                ),
                HeaderRow(
                  header: "After Discount",
                  value:
                      "${ticketList.map((ticket) => ticket.getPrice()).reduce((a, b) => a + b)}",
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    "Voucher".toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    onSubmitted: (content) {
                      // Check voucher
                    },
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    controller: _voucheController,
                    decoration: InputDecoration(
                      labelText: "Your voucher",
                      prefixIconColor: Colors.white,
                      suffixIconColor: Colors.white,
                      prefixIcon: const Icon(Icons.card_giftcard_outlined),
                      suffixIcon: InkWell(
                        onTap: () => _voucheController.text.isEmpty
                            ? {}
                            : _voucheController.clear(),
                        child: const Icon(Icons.check),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    "Payment".toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FutureBuilder(
                  future: getPaymentMethod(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      )); // Hoặc bất kỳ Widget nào để hiển thị trạng thái chờ
                    }
                    if (snapshot.hasError) {
                      print("Error: ${snapshot.error}");
                      return Text(
                        'Error: ${snapshot.error}',
                        style: ThemeConfig.nearlyWhiteTextStyle(),
                      ); // Xử lý lỗi
                    }
                    return ValueListenableBuilder(
                        valueListenable: _currentIndex,
                        builder: (context, value, child) {
                          return Column(
                            children: List.generate(
                                paymentMethodList.length,
                                (index) => PaymentRow(
                                      header: paymentMethodList[index].name,
                                      link: paymentMethodList[index].iconLink,
                                      selected: index == _currentIndex.value,
                                      onTap: () =>
                                          {_currentIndex.value = index},
                                    )),
                          );
                        });
                  },
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: MediaQuery.sizeOf(context).height / 10,
          color: Colors.black,
          child: TextButton(
            onPressed: () async {
              _loading.value = true;
              Bill newBill = Bill(
                userId: GlobalUtils.currentAccount!.uid!,
                date: DateTime.now().toString(),
                voucherId: "null",
                paymentMethodId: paymentMethodList[_currentIndex.value].id,
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
              await APIService.pushToFireBase(
                  "bills/${newBill.id}/", newBill.toMap());
              _loading.value = false;
              Navigator.of(context).popUntil((route) => route.isFirst);
              Fluttertoast.showToast(
                  msg: "Book success!!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  textColor: Colors.black,
                  backgroundColor: Colors.white,
                  fontSize: 16.0);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: const Text("Pay"),
          ),
        ),
      ),
      ValueListenableBuilder(
        valueListenable: _loading,
        builder: (context, value, child) {
          return Visibility(
            visible: _loading.value,
            child: const FullScreenCircularProgress(),
          );
        },
      ),
    ]);
  }
}

class PaymentPageAppBarBody extends StatelessWidget {
  const PaymentPageAppBarBody({
    super.key,
    required this.screenSize,
    required this.movie,
    required this.schedule,
    required this.theater,
    required this.ticketList,
  });

  final Size screenSize;
  final Movie movie;
  final Schedule schedule;
  final Theater theater;
  final List<Ticket> ticketList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Row(
          children: [
            AppBarBackButton(),
            Expanded(
              child: Text(
                "Payment",
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
        BillDetailWidget(
            screenSize: screenSize,
            movie: movie,
            schedule: schedule,
            theater: theater,
            ticketList: ticketList),
      ],
    );
  }
}

class BillDetailWidget extends StatelessWidget {
  const BillDetailWidget({
    super.key,
    required this.screenSize,
    required this.movie,
    required this.schedule,
    required this.theater,
    required this.ticketList,
  });

  final Size screenSize;
  final Movie movie;
  final Schedule schedule;
  final Theater theater;
  final List<Ticket> ticketList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BillDetailRow(
            screenSize: screenSize,
            movie: movie,
            schedule: schedule,
            theater: theater,
            ticketList: ticketList),
        const SizedBox(height: 20),
        Text(
          "Total: ${ticketList.isEmpty ? 0 : ticketList.map((ticket) => ticket.getPrice()).reduce((a, b) => a + b)}\$",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

class BillDetailRow extends StatelessWidget {
  const BillDetailRow({
    super.key,
    required this.screenSize,
    required this.movie,
    required this.schedule,
    required this.theater,
    required this.ticketList,
  });

  final Size screenSize;
  final Movie movie;
  final Schedule schedule;
  final Theater theater;
  final List<Ticket> ticketList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: screenSize.width / 4,
          height: screenSize.width / 4 * 3 / 2,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(movie.getPosterFullPath())),
            //color: Colors.amber,
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title
                Text(
                  movie.title,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  MyHelper.getDateInfo(
                      MyHelper.fromStringToDate(schedule.date)),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "${MyHelper.getTimeFromMin(schedule.time)} ~ ${MyHelper.getTimeFromMin(schedule.time + movie.runtime + 15)}",
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  theater.name,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Cinema ${schedule.roomId.split("_")[0]}",
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Seat: ${ticketList.isEmpty ? 0 : ticketList.map((ticket) => ticket.seatId.split("_").last).reduce((a, b) => "$a, $b")}",
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class HeaderRow extends StatelessWidget {
  HeaderRow({
    super.key,
    this.backgroundColor = Colors.black,
    this.borderColor = Colors.white,
    this.header = "Sample",
    this.value = "000",
  });
  Color backgroundColor, borderColor;
  String header, value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border(bottom: BorderSide(color: borderColor))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  header,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentRow extends StatelessWidget {
  PaymentRow({
    super.key,
    this.backgroundColor = Colors.black,
    this.borderColor = Colors.white,
    this.header = "Sample",
    this.link =
        "https://cdn.freebiesupply.com/logos/thumbs/2x/apple-pay-payment-mark-logo.png",
    this.selected = false,
    required this.onTap,
  });
  Color backgroundColor, borderColor;
  String header, link;
  bool selected;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border(bottom: BorderSide(color: borderColor))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: 0,
                            minWidth: 0,
                            maxWidth: MediaQuery.sizeOf(context).width / 8,
                            maxHeight: MediaQuery.sizeOf(context).width / 8,
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover, image: NetworkImage(link)),
                            //color: Colors.amber,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                          ),
                          // child: Image.network(
                          //   link,
                          //   width: MediaQuery.sizeOf(context).width / 8,
                          ///),
                        ),
                      ),
                      Text(
                        header,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: selected,
                    child: const Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
