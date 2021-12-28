part of 'tv_series_detail_bloc.dart';

///
/// Created by handy on 23/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

abstract class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class IdTvSeriesDetailResult extends TvSeriesDetailEvent {
  final int id;

  IdTvSeriesDetailResult(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];

}

class OnTvSeriesRecommendationResult extends TvSeriesDetailEvent {
  final TVSeriesDetail tvSeriesDetail;

  OnTvSeriesRecommendationResult(this.tvSeriesDetail);

 @override
  // TODO: implement props
  List<Object?> get props => [tvSeriesDetail];
}
