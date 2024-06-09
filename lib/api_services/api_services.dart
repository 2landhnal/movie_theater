import 'package:flutter/scheduler.dart';
import 'package:movie_theater/data/dataClasses.dart';
import 'package:movie_theater/helpers/helper.dart';
import 'package:movie_theater/utils/asset.dart';

class APIService {
  static Future<List<Movie>?> getAllMovies() async {
    List<Movie> movies = [];
    var snapshot = await GlobalUtils.dbInstance.ref().child('movies').get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      for (var child in snapshot.children) {
        movies.add(Movie.fromMap(child.value as Map));
      }
      print("DONE!!");
      return movies;
    } else {
      print('No data available.');
    }
    return null;
  }

  static Future<List<Bill>> getUserBills() async {
    List<Bill> bills = [];
    var snapshot = await GlobalUtils.dbInstance
        .ref()
        .child('bills')
        .orderByChild("userId")
        .equalTo(GlobalUtils.currentAccount!.username)
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return [];
      for (var child in snapshot.children) {
        bills.add(Bill.fromMap(child.value as Map));
      }
      print("DONE!!");
      return bills;
    } else {
      print('No data available.');
    }
    return [];
  }

  static Future<List<BillDetail>> getBillDetailListByBill(String billId) async {
    List<BillDetail> payMethods = [];
    var snapshot = await GlobalUtils.dbInstance
        .ref()
        .child('bill_details')
        .orderByChild("billId")
        .equalTo(billId)
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return [];
      for (var child in snapshot.children) {
        payMethods.add(BillDetail.fromMap(child.value as Map));
      }
      print("DONE!!");
      return payMethods;
    } else {
      print('No data available.');
    }
    return [];
  }

  static Future<List<PaymentMethod>> getAllPayMethod() async {
    List<PaymentMethod> payMethods = [];
    var snapshot =
        await GlobalUtils.dbInstance.ref().child('payment_methods').get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return [];
      for (var child in snapshot.children) {
        payMethods.add(PaymentMethod.fromMap(child.value as Map));
      }
      print("DONE!!");
      return payMethods;
    } else {
      print('No data available.');
    }
    return [];
  }

  static Future<List<Movie_Genre>?> getMovieGenreList(int movieId) async {
    List<Movie_Genre> movieGenreList = [];
    var snapshot = await GlobalUtils.dbInstance
        .ref()
        .child('movie_genre')
        .child(movieId.toString())
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      for (var child in snapshot.children) {
        movieGenreList.add(Movie_Genre.fromMap(child.value as Map));
      }
      return movieGenreList;
    } else {
      print('No data available.');
    }
    return [];
  }

  static Future<List<TicketPriceSchedule>> getTicketPriceBySchedule(
      String id) async {
    List<TicketPriceSchedule> ticketPriceList = [];
    var snapshot = await GlobalUtils.dbInstance
        .ref()
        .child('ticket_price_schedule')
        .child(id)
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return [];
      for (var child in snapshot.children) {
        ticketPriceList.add(TicketPriceSchedule.fromMap(child.value as Map));
      }
      return ticketPriceList;
    } else {
      print('No data available.');
    }
    return [];
  }

  static Future<List<Credit>?> getMovieCreditList(int movieId) async {
    List<Credit> movieCreditList = [];
    var snapshot = await GlobalUtils.dbInstance
        .ref()
        .child('credits')
        .child(movieId.toString())
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      for (var child in snapshot.children) {
        movieCreditList.add(Credit.fromMap(child.value as Map));
      }
      return movieCreditList;
    } else {
      print('No data available.');
    }
    return [];
  }

  static Future<List<Room_Seat>?> getRoomSeatList(String roomId) async {
    List<Room_Seat> roomSeat = [];
    var snapshot = await GlobalUtils.dbInstance
        .ref()
        .child('room_seat')
        .child(roomId)
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      for (var child in snapshot.children) {
        roomSeat.add(Room_Seat.fromMap(child.value as Map));
      }
      return roomSeat;
    } else {
      print('No data available.');
    }
    return [];
  }

  static Future<List<Ticket>> getTicketListBySchedule(String scheduleId) async {
    List<Ticket> tickets = [];
    var snapshot = await GlobalUtils.dbInstance
        .ref()
        .child('tickets')
        .orderByChild('scheduleId')
        .equalTo(scheduleId)
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return [];
      for (var child in snapshot.children) {
        tickets.add(Ticket.fromMap(child.value as Map));
      }
      return tickets;
    } else {
      print('No data available.');
    }
    return [];
  }

  static Future<Participant?> getParticipantByID(int id) async {
    var snapshot = await GlobalUtils.dbInstance
        .ref()
        .child('participants')
        .child(id.toString())
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      Participant result = Participant.fromMap(snapshot.value as Map);
      return result;
    } else {
      print('No data available.');
    }
    return null;
  }

  static Future<DateTime> getEndScheduleTimeByBill(String billId) async {
    DateTime dt;
    Schedule schedule = (await getScheduleByBill(billId)) as Schedule;
    Movie movie = (await getMovieById(schedule.movieId)) as Movie;
    dt = DateTime.parse(schedule.date);
    int tmp = (schedule.time + movie.runtime + 15);
    bool newDay = tmp >= 1440;
    tmp %= 1440;
    int hour = tmp ~/ 60;
    int min = tmp % 60;
    dt = DateTime(dt.year, dt.month, dt.day + (newDay ? 1 : 0), hour, min);
    return dt;
  }

  static Future<List<Ticket>> getTicketListByBill(String billId) async {
    List<BillDetail> billDetails =
        await APIService.getBillDetailListByBill(billId);
    List<Ticket> tickets = [];
    for (var v in billDetails) {
      Ticket? t = await APIService.getProductById(v.productId) as Ticket?;
      tickets.add(t!);
    }
    return tickets;
  }

  static Future<Product?> getProductById(String id) async {
    try {
      var snapshot =
          await GlobalUtils.dbInstance.ref().child('tickets').child(id).get();
      final data = snapshot.value;
      if (data == null) return null;
      Ticket result = Ticket.fromMap(snapshot.value as Map);
      return result;
    } catch (e) {
      try {
        // Food here
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
    return null;
  }

  static Future<Schedule?> getScheduleByBill(String billId) async {
    List<BillDetail> billDetails =
        await APIService.getBillDetailListByBill(billId);
    String scheduleId = "";
    for (var v in billDetails) {
      print("before");
      Ticket? t = await APIService.getProductById(v.productId) as Ticket?;
      scheduleId = t!.scheduleId;
      print("after");
      break;
    }
    Schedule? res = await getScheduleById(scheduleId);
    return res;
  }

  static Future<Theater?> getTheaterById(String id) async {
    var snapshot =
        await GlobalUtils.dbInstance.ref().child('theaters').child(id).get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      Theater result = Theater.fromMap(snapshot.value as Map);
      return result;
    } else {
      print('No data available.');
    }
    return null;
  }

  static Future<Room?> getRoomById(String id) async {
    var snapshot =
        await GlobalUtils.dbInstance.ref().child('rooms').child(id).get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      Room result = Room.fromMap(snapshot.value as Map);
      return result;
    } else {
      print('No data available.');
    }
    return null;
  }

  static Future<Genre?> getGenreByID(int id) async {
    var snapshot = await GlobalUtils.dbInstance
        .ref()
        .child('genres')
        .child(id.toString())
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      Genre result = Genre.fromMap(snapshot.value as Map);
      return result;
    } else {
      print('No data available.');
    }
    return null;
  }

  static Future<Account?> getAccountByAccount(String account) async {
    var snapshot = await GlobalUtils.dbInstance
        .ref()
        .child('accounts')
        .child(account)
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      Account result = Account.fromMap(snapshot.value as Map);
      return result;
    } else {
      print('No data available.');
    }
    return null;
  }

  static Future<void> pushToFireBase(
      String ref, Map<String, dynamic> map) async {
    await GlobalUtils.dbInstance.ref(ref).set(map).then((_) {
      print("Set success");
    }).catchError((onError) {
      print(onError);
    });
  }

  static Future<Customer?> getCustomerByAccount(String account) async {
    var snapshot = await GlobalUtils.dbInstance
        .ref()
        .child('customers')
        .child(account)
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      Customer result = Customer.fromMap(snapshot.value as Map);
      return result;
    } else {
      print('No data available.');
    }
    return null;
  }

  static Future<Schedule?> getScheduleById(String id) async {
    var snapshot =
        await GlobalUtils.dbInstance.ref().child('schedules').child(id).get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      Schedule result = Schedule.fromMap(snapshot.value as Map);
      return result;
    } else {
      print('No data available.');
    }
    return null;
  }

  static Future<Room_Seat?> getSeatById(String id) async {
    var seatName = id.split("_").last;
    var roomId = id.substring(0, id.length - seatName.length - 1);
    var snapshot = await GlobalUtils.dbInstance
        .ref()
        .child('room_seat')
        .child(roomId)
        .child(id)
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      Room_Seat result = Room_Seat.fromMap(snapshot.value as Map);
      return result;
    } else {
      print('No data available.');
    }
    return null;
  }

  static Future<Movie?> getMovieById(String id) async {
    var snapshot =
        await GlobalUtils.dbInstance.ref().child('movies').child(id).get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      Movie result = Movie.fromMap(snapshot.value as Map);
      return result;
    } else {
      print('No data available.');
    }
    return null;
  }

  static Future<List<Schedule>?> getScheduleListByDate(String date) async {
    List<Schedule> scheduleList = [];
    var snapshot =
        await GlobalUtils.dbInstance.ref().child('schedules').child(date).get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      for (var child in snapshot.children) {
        scheduleList.add(Schedule.fromMap(child.value as Map));
      }
      return scheduleList;
    } else {
      print('No data available.');
    }
    return [];
  }

  static Future<List<Schedule>?> getScheduleListByDateAndMovie(
      String date, String movieId) async {
    List<Schedule> scheduleList = [];
    var snapshot = await GlobalUtils.dbInstance
        .ref()
        .child('schedules')
        .orderByChild("date")
        .equalTo(date)
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      for (var child in snapshot.children) {
        var tmp = Schedule.fromMap(child.value as Map);
        if (tmp.movieId == movieId) scheduleList.add(tmp);
      }
      return scheduleList;
    } else {
      print('No data available.');
    }
    return [];
  }

  static Future<List<Schedule>?> getScheduleListByDateAndMovieAndTheater(
      String date, String movieId, String theaterId) async {
    List<Schedule> scheduleList = [];
    var snapshot = await GlobalUtils.dbInstance
        .ref()
        .child('schedules')
        .orderByChild("date")
        .equalTo(date)
        .get();
    if (snapshot.exists) {
      final data = snapshot.value;
      if (data == null) return null;
      for (var child in snapshot.children) {
        var tmp = Schedule.fromMap(child.value as Map);
        if (tmp.movieId == movieId && tmp.roomId.split("_")[0] == theaterId) {
          scheduleList.add(tmp);
        }
      }
      return scheduleList;
    } else {
      print('No data available.');
    }
    return [];
  }
}
