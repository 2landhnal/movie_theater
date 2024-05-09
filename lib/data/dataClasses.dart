import 'dart:convert';

class Account {
  String username;
  String name;
  String password;
  String email;
  String birthday;
  String gender;
  int role_id;
  String join_at;
  Account({
    required this.username,
    required this.name,
    required this.password,
    required this.email,
    required this.birthday,
    required this.gender,
    required this.role_id,
    required this.join_at,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'name': name,
      'password': password,
      'email': email,
      'birthday': birthday,
      'gender': gender,
      'role_id': role_id,
      'join_at': join_at,
    };
  }

  factory Account.fromMap(Map<dynamic, dynamic> map) {
    return Account(
      username: map['username'] as String,
      name: map['name'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      birthday: map['birthday'] as String,
      gender: map['gender'] as String,
      role_id: map['role_id'] as int,
      join_at: map['join_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source) as Map<String, dynamic>);
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
