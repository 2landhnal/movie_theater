import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:movie_theater/api_services/api_services.dart';

class SystemUser {
  String username;
  String name;
  String email;
  String birthday;
  String gender;
  String join_at;
  SystemUser({
    required this.username,
    required this.name,
    required this.email,
    required this.birthday,
    required this.gender,
    required this.join_at,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'name': name,
      'email': email,
      'birthday': birthday,
      'gender': gender,
      'join_at': join_at,
    };
  }

  factory SystemUser.fromMap(Map<dynamic, dynamic> map) {
    return SystemUser(
      username: map['username'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      birthday: map['birthday'] as String,
      gender: map['gender'] as String,
      join_at: map['join_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SystemUser.fromJson(String source) =>
      SystemUser.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Customer extends SystemUser {
  Customer({
    required super.username,
    required super.name,
    required super.email,
    required super.birthday,
    required super.gender,
    required super.join_at,
  });
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'name': name,
      'email': email,
      'birthday': birthday,
      'gender': gender,
      'join_at': join_at,
    };
  }

  factory Customer.fromMap(Map<dynamic, dynamic> map) {
    return Customer(
      username: map['username'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      birthday: map['birthday'] as String,
      gender: map['gender'] as String,
      join_at: map['join_at'] as String,
    );
  }

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Account {
  String username;
  String password;
  int role_id;
  String salt;
  Account({
    required this.username,
    required this.password,
    required this.role_id,
    required this.salt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'role_id': role_id,
      'salt': salt,
    };
  }

  factory Account.fromMap(Map<dynamic, dynamic> map) {
    return Account(
      username: map['username'] as String,
      password: map['password'] as String,
      role_id: map['role_id'] as int,
      salt: map['salt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source) as Map<String, dynamic>);
}

class BillDetail {
  String id;
  String productId;
  int quantity;
  String billId;
  BillDetail(
      {required this.productId,
      this.quantity = 1,
      required this.billId,
      this.id = ""}) {
    id = "${billId}_$productId";
  }
  Product getProduct() {
    return Ticket(id: "", scheduleId: "", billId: "", seatId: "");
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'billId': billId,
    };
  }

  factory BillDetail.fromMap(Map<dynamic, dynamic> map) {
    return BillDetail(
      id: map['id'] as String,
      productId: map['productId'] as String,
      quantity: map['quantity'] as int,
      billId: map['billId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BillDetail.fromJson(String source) =>
      BillDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Bill {
  String id;
  String userId;
  String date;
  String voucherId;
  String paymentMethodId;
  Bill(
      {this.id = "",
      required this.userId,
      required this.date,
      required this.voucherId,
      required this.paymentMethodId}) {
    id =
        "${userId}_${date.replaceAll(" ", "_").replaceAll(RegExp(r'[.#\[\]\$]'), "?")}";
  }

  Future<double> getBillPrice() async {
    List<BillDetail> billDetails = await APIService.getBillDetailListByBill(id);
    List<Ticket> tickets = [];
    for (var v in billDetails) {
      Ticket? t = await APIService.getProductById(v.productId) as Ticket?;
      tickets.add(t!);
    }
    double res = 0;
    for (var t in tickets) {
      await t._fetchPrice();
      res += t.getPrice();
    }
    return res;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'date': date,
      'voucherId': voucherId,
      'paymentMethodId': paymentMethodId,
    };
  }

  factory Bill.fromMap(Map<dynamic, dynamic> map) {
    return Bill(
      id: map['id'] as String,
      userId: map['userId'] as String,
      date: map['date'] as String,
      voucherId: map['voucherId'] as String,
      paymentMethodId: map['paymentMethodId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bill.fromJson(String source) =>
      Bill.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Genre {
  String id;
  String name;
  Genre({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Genre.fromMap(Map<dynamic, dynamic> map) {
    return Genre(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Genre.fromJson(String source) =>
      Genre.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Schedule {
  String movieId;
  String roomId;
  String date;
  int time;
  String id;
  Schedule({
    required this.movieId,
    required this.roomId,
    required this.date,
    required this.time,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'movieId': movieId,
      'roomId': roomId,
      'date': date,
      'time': time,
      'id': id,
    };
  }

  factory Schedule.fromMap(Map<dynamic, dynamic> map) {
    return Schedule(
      movieId: map['movieId'] as String,
      roomId: map['roomId'] as String,
      date: map['date'] as String,
      time: map['time'] as int,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Schedule.fromJson(String source) =>
      Schedule.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Theater {
  String id;
  String name;
  String added_at;
  String loc;
  double lat;
  double lon;
  Theater({
    required this.id,
    required this.name,
    required this.added_at,
    required this.loc,
    required this.lat,
    required this.lon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'added_at': added_at,
      'loc': loc,
      'lat': lat,
      'lon': lon,
    };
  }

  factory Theater.fromMap(Map<dynamic, dynamic> map) {
    return Theater(
      id: map['id'] as String,
      name: map['name'] as String,
      added_at: map['added_at'] as String,
      loc: map['loc'] as String,
      lat: map['lat'] as double,
      lon: map['lon'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Theater.fromJson(String source) =>
      Theater.fromMap(json.decode(source) as Map<String, dynamic>);
}

abstract class Product {
  String id;
  Product({
    required this.id,
  });
  double getPrice();
}

class PaymentMethod {
  String id;
  String name;
  String iconLink;
  PaymentMethod({
    required this.id,
    required this.name,
    required this.iconLink,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'iconLink': iconLink,
    };
  }

  factory PaymentMethod.fromMap(Map<dynamic, dynamic> map) {
    return PaymentMethod(
      id: map['id'] as String,
      name: map['name'] as String,
      iconLink: map['iconLink'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethod.fromJson(String source) =>
      PaymentMethod.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TicketPriceSchedule {
  int seatType;
  int price;
  String scheduleId;
  TicketPriceSchedule({
    required this.seatType,
    required this.price,
    required this.scheduleId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'seatType': seatType,
      'price': price,
      'scheduleId': scheduleId,
    };
  }

  factory TicketPriceSchedule.fromMap(Map<dynamic, dynamic> map) {
    return TicketPriceSchedule(
      seatType: map['seatType'] as int,
      price: map['price'] as int,
      scheduleId: map['scheduleId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TicketPriceSchedule.fromJson(String source) =>
      TicketPriceSchedule.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Ticket extends Product {
  String scheduleId;
  String seatId;
  String billId;
  bool ordered;
  int _price = 0;

  Ticket({
    required super.id, // Add id parameter
    required this.scheduleId,
    required this.seatId,
    required this.billId,
    this.ordered = false, // Provide default value for ordered
  }) {
    _fetchPrice();
  } // Call the super constructor

  Future<void> _fetchPrice() async {
    var map = await APIService.getTicketPriceBySchedule(scheduleId);
    var seat = await APIService.getSeatById(seatId);
    for (var m in map) {
      if (m.seatType == seat!.seatType) {
        _price = m.price;
        return;
      }
    }
    _price = 999999999;
  }

  @override
  double getPrice() {
    // TODO: implement getPrice
    return _price.toDouble(); // Replace with actual implementation
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'scheduleId': scheduleId,
      'seatId': seatId,
      'billId': billId,
      'ordered': ordered,
    };
  }

  factory Ticket.fromMap(Map<dynamic, dynamic> map) {
    return Ticket(
      id: map['id'] as String,
      scheduleId: map['scheduleId'] as String,
      seatId: map['seatId'] as String,
      billId: map['billId'] as String,
      ordered: map['ordered'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ticket.fromJson(String source) =>
      Ticket.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Room {
  String id;
  String name;
  String theaterId;
  int room_type;
  Room({
    required this.id,
    required this.name,
    required this.theaterId,
    required this.room_type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'theaterId': theaterId,
      'room_type': room_type,
    };
  }

  factory Room.fromMap(Map<dynamic, dynamic> map) {
    return Room(
      id: map['id'] as String,
      name: map['name'] as String,
      theaterId: map['theaterId'] as String,
      room_type: map['room_type'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) =>
      Room.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Room_Seat {
  String roomId;
  String id;
  int seatType;
  String name;
  Room_Seat({
    required this.roomId,
    required this.id,
    required this.seatType,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomId': roomId,
      'id': id,
      'seatType': seatType,
      'name': name,
    };
  }

  factory Room_Seat.fromMap(Map<dynamic, dynamic> map) {
    return Room_Seat(
      roomId: map['roomId'] as String,
      id: map['id'] as String,
      seatType: map['seatType'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Room_Seat.fromJson(String source) =>
      Room_Seat.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Participant {
  int gender;
  int id;
  String name;
  String profile_path;
  Participant({
    required this.gender,
    required this.id,
    required this.name,
    required this.profile_path,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gender': gender,
      'id': id,
      'name': name,
      'profile_path': profile_path,
    };
  }

  factory Participant.fromMap(Map<dynamic, dynamic> map) {
    if (map['profile_path'] == null) {
      map['profile_path'] = '';
    }
    return Participant(
      gender: map['gender'] as int,
      id: map['id'] as int,
      name: map['name'] as String,
      profile_path: map['profile_path'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Participant.fromJson(String source) =>
      Participant.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Credit {
  String id;
  int movieID;
  int particapantID;
  int departmentID;
  Credit({
    required this.id,
    required this.movieID,
    required this.particapantID,
    required this.departmentID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'movieID': movieID,
      'particapantID': particapantID,
      'departmentID': departmentID,
    };
  }

  factory Credit.fromMap(Map<dynamic, dynamic> map) {
    return Credit(
      id: map['id'] as String,
      movieID: map['movieID'] as int,
      particapantID: map['particapantID'] as int,
      departmentID: map['departmentID'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Credit.fromJson(String source) =>
      Credit.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Movie_Genre {
  int genreId;
  int movieId;
  Movie_Genre({
    required this.genreId,
    required this.movieId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'genreId': genreId,
      'movieId': movieId,
    };
  }

  factory Movie_Genre.fromMap(Map<dynamic, dynamic> map) {
    return Movie_Genre(
      genreId: map['genreId'] as int,
      movieId: map['movieId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie_Genre.fromJson(String source) =>
      Movie_Genre.fromMap(json.decode(source) as Map<String, dynamic>);
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Movie {
  int id;
  String original_language;
  String overview;
  String release_date;
  String poster_path;
  String title;
  int runtime;
  num vote_average;
  String streaming_state;
  Movie({
    required this.id,
    required this.original_language,
    required this.overview,
    required this.release_date,
    required this.poster_path,
    required this.title,
    required this.runtime,
    required this.vote_average,
    required this.streaming_state,
  });

  String getPosterFullPath() {
    return "https://image.tmdb.org/t/p/w500$poster_path";
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'original_language': original_language,
      'overview': overview,
      'release_date': release_date,
      'poster_path': poster_path,
      'title': title,
      'runtime': runtime,
      'vote_average': vote_average,
      'streaming_state': streaming_state,
    };
  }

  factory Movie.fromMap(Map<dynamic, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      original_language: map['original_language'] as String,
      overview: map['overview'] as String,
      release_date: map['release_date'] as String,
      poster_path: map['poster_path'] as String,
      title: map['title'] as String,
      runtime: map['runtime'] as int,
      vote_average: map['vote_average'] as num,
      streaming_state: map['streaming_state'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) =>
      Movie.fromMap(json.decode(source) as Map<String, dynamic>);
}
