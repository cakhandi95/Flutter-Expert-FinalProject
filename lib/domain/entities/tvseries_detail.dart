import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class TVSeriesDetail extends Equatable {
  TVSeriesDetail({
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
  List<Genre> genres;
  List<Season> seasons;
  int id;
  String name;
  List<String>? origin_country;
  String? original_name;
  String overview;
  double? popularity;
  String? poster_path;
  double vote_average;
  int? vote_count;
  int number_of_seasons;

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
