import 'package:equatable/equatable.dart';

class TVSeriesEpisode extends Equatable {
  TVSeriesEpisode({
    required this.air_date,
    required this.id,
    required this.still_path,
    required this.name,
    required this.overview,
    required this.vote_average,
    required this.vote_count,
  });

  String still_path;
  String air_date;
  int id;
  String name;
  String overview;
  double vote_average;
  int? vote_count;

  @override
  List<Object?> get props => [
    still_path,
    air_date,
    id,
    name,
    overview,
    vote_average,
    vote_count,
  ];
}
