import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:equatable/equatable.dart';

class TVSeriesTable extends Equatable {
  final int id;
  final String? name;
  final String? poster_path;
  final String? overview;

  TVSeriesTable({
    required this.id,
    required this.name,
    required this.poster_path,
    required this.overview,
  });

  factory TVSeriesTable.fromEntity(TVSeriesDetail movie) => TVSeriesTable(
    id: movie.id,
    name: movie.name,
    poster_path: movie.poster_path,
    overview: movie.overview,
  );

  factory TVSeriesTable.fromMap(Map<String, dynamic> map) => TVSeriesTable(
    id: map['id'],
    name: map['name'],
    poster_path: map['poster_path'],
    overview: map['overview'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'poster_path': poster_path,
    'overview': overview,
  };

  TVSeries toEntity() => TVSeries.watchlist(
    id: id,
    overview: overview,
    poster_path: poster_path,
    name: name,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, poster_path, overview];
}
