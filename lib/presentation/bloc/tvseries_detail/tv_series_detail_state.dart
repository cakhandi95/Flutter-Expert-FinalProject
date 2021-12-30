part of 'tv_series_detail_bloc.dart';

///
/// Created by handy on 23/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

abstract class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvSeriesDetailInit extends TvSeriesDetailState { }

class TvSeriesDetailIsLoading extends TvSeriesDetailState { }

class TvSeriesDetailLoaded extends TvSeriesDetailState {

  final TVSeriesDetail tvSeriesDetail;
  final List<TVSeries> recommendations;
  final bool isCheckedLoaded;

  TvSeriesDetailLoaded(this.tvSeriesDetail,this.isCheckedLoaded, {this.recommendations = const[]});
}

class TvSeriesDetailError extends TvSeriesDetailState {

  final String errMessage;
  final Function tryAgain;

  TvSeriesDetailError(this.errMessage, {required this.tryAgain});
 
  @override
  // TODO: implement props
  List<Object?> get props => [errMessage];
}