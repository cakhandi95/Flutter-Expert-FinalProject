import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:equatable/equatable.dart';

class TVSeriesDetailModel extends Equatable {
  TVSeriesDetailModel({
    required this.backdrop_path,
    required this.first_air_date,
    required this.genres,
    required this.id,
    required this.name,
    required this.origin_country,
    required this.original_name,
    required this.overview,
    required this.popularity,
    required this.poster_path,
    required this.vote_average,
    required this.vote_count,
    required this.seasons,
    required this.number_of_seasons,
  });

  String? backdrop_path;
  String? first_air_date;
  final List<GenreModel> genres;
  int id;
  String name;
  List<String> origin_country;
  String? original_name;
  String overview;
  double? popularity;
  String poster_path;
  double vote_average;
  int? vote_count;
  final List<SeasonModel> seasons;
  int number_of_seasons;

  factory TVSeriesDetailModel.fromJson(Map<String, dynamic> json) => TVSeriesDetailModel(
    backdrop_path: json["backdrop_path"],
    first_air_date: json["first_air_date"],
    genres: List<GenreModel>.from(
        json["genres"].map((x) => GenreModel.fromJson(x))),
    id: json["id"],
    name: json["name"],
    origin_country: List<String>.from(json["origin_country"].map((x) => x)),
    original_name: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"].toDouble(),
    poster_path: json["poster_path"],
    vote_average: json["vote_average"].toDouble(),
    vote_count: json["vote_count"],
    seasons: List<SeasonModel>.from(
        json["seasons"].map((x) => SeasonModel.fromJson(x))),
      number_of_seasons : json["number_of_seasons"]

  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdrop_path,
    "first_air_date": first_air_date,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "id": id,
    "name": name,
    "origin_country": List<dynamic>.from(origin_country.map((x) => x)),
    "original_name": original_name,
    "overview": overview,
    "popularity": popularity,
    "poster_path": poster_path,
    "vote_average": vote_average,
    "vote_count": vote_count,
    "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
    "number_of_seasons" : number_of_seasons,
  };

  TVSeriesDetail toEntity() {
    return TVSeriesDetail(
      backdrop_path: this.backdrop_path,
      first_air_date: this.first_air_date,
      genres : this.genres.map((genre) => genre.toEntity()).toList(),
      id: this.id,
      name: this.name,
      origin_country: this.origin_country,
      original_name: this.original_name,
      overview: this.overview,
      popularity: this.popularity,
      poster_path: this.poster_path,
      vote_average: this.vote_average,
      vote_count: this.vote_count,
      seasons : this.seasons.map((season) => season.toEntity()).toList(), number_of_seasons: number_of_seasons,
    );
  }

  @override
  List<Object?> get props => [
    backdrop_path,
    first_air_date,
    genres,
    id,
    name,
    origin_country,
    original_name,
    overview,
    popularity,
    poster_path,
    vote_average,
    vote_count,
    seasons,
    number_of_seasons,
  ];
}
