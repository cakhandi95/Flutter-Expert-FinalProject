import 'package:equatable/equatable.dart';

class Season extends Equatable {
  Season({
    required this.air_date,
    required this.episode_count,
    required this.id,
    required this.name,
    required this.overview,
    required this.poster_path,
    required this.season_number,
  });

  final String air_date;
  final int episode_count;
  final int id;
  final String name;
  final String overview;
  final String poster_path;
  final int season_number;

  @override
  List<Object> get props => [
    air_date,
    episode_count,
    id,
    name,
    overview,
    poster_path,
    season_number,
  ];
}
