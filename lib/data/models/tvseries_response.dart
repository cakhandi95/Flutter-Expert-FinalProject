import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:equatable/equatable.dart';

class TVSeriesResponse extends Equatable {
  final List<TVSeriesModel> tvseriesList;

  TVSeriesResponse({required this.tvseriesList});

  factory TVSeriesResponse.fromJson(Map<String, dynamic> json) => TVSeriesResponse(
    tvseriesList: List<TVSeriesModel>.from((json["results"] as List)
        .map((x) => TVSeriesModel.fromJson(x))
        .where((element) => element.poster_path != null)),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(tvseriesList.map((x) => x.toJson())),
  };

  @override
  List<Object> get props => [tvseriesList];
}
