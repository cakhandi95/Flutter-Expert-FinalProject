import 'package:ditonton/data/models/tvseries_episode_model.dart';
import 'package:equatable/equatable.dart';

class TVSeriesEpisodeResponse extends Equatable {
  final List<TVSeriesEpisodeModel> tvseriesEpisodeList;

  TVSeriesEpisodeResponse({required this.tvseriesEpisodeList});

  factory TVSeriesEpisodeResponse.fromJson(Map<String, dynamic> json) => TVSeriesEpisodeResponse(
    tvseriesEpisodeList: List<TVSeriesEpisodeModel>.from((json["episodes"] as List)
        .map((x) => TVSeriesEpisodeModel.fromJson(x))
        .where((element) => element.still_path != null)),
  );

  Map<String, dynamic> toJson() => {
    "episodes": List<dynamic>.from(tvseriesEpisodeList.map((x) => x.toJson())),
  };

  @override
  List<Object> get props => [tvseriesEpisodeList];
}
