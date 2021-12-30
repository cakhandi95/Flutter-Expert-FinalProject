import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';

///
/// Created by handy on 28/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

abstract class WatchListTvSeriesState extends Equatable {

  const WatchListTvSeriesState();

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class WatchListTvSeriesInit extends WatchListTvSeriesState { }

class WatchListTvSeriesIsLoading extends WatchListTvSeriesState { }

class WatchListTvSeriesError extends WatchListTvSeriesState {
  final String errMessage;
  final Function tryAgain;

  WatchListTvSeriesError(this.errMessage,{required this.tryAgain});

  @override
  // TODO: implement props
  List<Object?> get props => [errMessage];

}
class WatchListTvSeriesLoaded extends WatchListTvSeriesState {
  final List<TVSeries> watchlistTVSeries;

  WatchListTvSeriesLoaded(this.watchlistTVSeries);

  @override
  // TODO: implement props
  List<Object?> get props => [watchlistTVSeries];

}