import 'package:ditonton/domain/entities/tvseries_episode.dart';
import 'package:equatable/equatable.dart';

class TVSeriesEpisodeModel extends Equatable {
  TVSeriesEpisodeModel({
    required this.air_date,
    required this.id,
    required this.still_path,
    required this.name,
    required this.overview,
    required this.vote_average,
    required this.vote_count,
  });

  String air_date;
  int id;
  String name;
  String overview;
  String still_path;
  double vote_average;
  int? vote_count;

  factory TVSeriesEpisodeModel.fromJson(Map<String, dynamic> json) => TVSeriesEpisodeModel(
    air_date: json["air_date"],
    id: json["id"],
    still_path: json["still_path"]==null?"":json["still_path"],
    name: json["name"],
    overview: json["overview"],
    vote_average: json["vote_average"].toDouble(),
    vote_count: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "air_date": air_date,
    "id": id,
    "still_path": still_path,
    "name": name,
    "overview": overview,
    "vote_average": vote_average,
    "vote_count": vote_count,
  };

  TVSeriesEpisode toEntity() {
    return TVSeriesEpisode(
      id: this.id,
      name: this.name,
      overview: this.overview,
      vote_average: this.vote_average,
      vote_count: this.vote_count,
      air_date: this.air_date,
      still_path: this.still_path,
    );
  }

  @override
  List<Object?> get props => [
    air_date,
    id,
    still_path,
    name,
    overview,
    vote_average,
    vote_count,
  ];
}
