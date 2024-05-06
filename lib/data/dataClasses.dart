import 'dart:convert';

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
