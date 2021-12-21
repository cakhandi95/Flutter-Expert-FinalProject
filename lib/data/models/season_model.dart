import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  SeasonModel({
    required this.air_date,
    required this.episode_count,
    required this.id,
    required this.name,
    required this.overview,
    required this.poster_path,
    required this.season_number,
  });

  String air_date;
  int episode_count;
  int id;
  String name;
  String overview;
  String poster_path;
  int season_number;

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
    air_date: json["air_date"]==null?"1990-01-01":json["air_date"],
    episode_count: json["episode_count"],
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    poster_path: json["poster_path"]==null?"":json["poster_path"],
    season_number: json["season_number"],
  );

  Map<String, dynamic> toJson() => {
    "air_date" : air_date,
    "episode_count" : episode_count,
    "id": id,
    "name": name,
    "overview": overview,
    "poster_path": poster_path,
    "season_number": season_number,
  };

  Season toEntity() {
    return Season(
        air_date: this.air_date,
        episode_count: this.episode_count,
        id: this.id,
        name: this.name,
        overview: this.overview,
        poster_path: this.poster_path,
        season_number: this.season_number,
    );
  }

  @override
  List<Object?> get props => [
    air_date,
    episode_count,
    id,
    name,
    overview,
    poster_path,
    season_number,
  ];
}
