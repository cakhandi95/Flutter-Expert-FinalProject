import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';

class TVSeriesModel extends Equatable {
  TVSeriesModel({
    required this.backdrop_path,
    required this.first_air_date,
    required this.genre_ids,
    required this.id,
    required this.name,
    required this.origin_country,
    required this.original_name,
    required this.overview,
    required this.popularity,
    required this.poster_path,
    required this.vote_average,
    required this.vote_count,
  });

  String? backdrop_path;
  String? first_air_date;
  List<int> genre_ids;
  int id;
  String? name;
  List<String> origin_country;
  String? original_name;
  String? overview;
  double? popularity;
  String? poster_path;
  double? vote_average;
  int? vote_count;

  factory TVSeriesModel.fromJson(Map<String, dynamic> json) => TVSeriesModel(
    backdrop_path: json["backdrop_path"],
    first_air_date: json["first_air_date"],
    genre_ids: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    name: json["name"],
    origin_country: List<String>.from(json["origin_country"].map((x) => x)),
    original_name: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"].toDouble(),
    poster_path: json["poster_path"],
    vote_average: json["vote_average"].toDouble(),
    vote_count: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdrop_path,
    "first_air_date": first_air_date,
    "genre_ids": List<dynamic>.from(genre_ids.map((x) => x)),
    "id": id,
    "name": name,
    "origin_country": List<dynamic>.from(origin_country.map((x) => x)),
    "original_name": original_name,
    "overview": overview,
    "popularity": popularity,
    "poster_path": poster_path,
    "vote_average": vote_average,
    "vote_count": vote_count,
  };

  TVSeries toEntity() {
    return TVSeries(
      backdrop_path: this.backdrop_path,
      first_air_date: this.first_air_date,
      genre_ids: this.genre_ids,
      id: this.id,
      name: this.name,
      origin_country: this.origin_country,
      original_name: this.original_name,
      overview: this.overview,
      popularity: this.popularity,
      poster_path: this.poster_path,
      vote_average: this.vote_average,
      vote_count: this.vote_count,
    );
  }

  @override
  List<Object?> get props => [
    backdrop_path,
    first_air_date,
    genre_ids,
    id,
    name,
    origin_country,
    original_name,
    overview,
    popularity,
    poster_path,
    vote_average,
    vote_count,
  ];
}
