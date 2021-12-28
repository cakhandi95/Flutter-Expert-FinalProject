part of 'top_rated_tvseries_bloc.dart';

///
/// Created by handy on 24/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

abstract class TopRatedTvSeriesState extends Equatable {
  const TopRatedTvSeriesState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TopRatedTvSeriesInit extends TopRatedTvSeriesState { }

class TopRatedTvSeriesIsLoading extends TopRatedTvSeriesState { }

class TopRatedTvSeriesLoaded extends TopRatedTvSeriesState {

  final List<TVSeries> topRatedTvSeries;

  TopRatedTvSeriesLoaded(this.topRatedTvSeries);

  @override
  // TODO: implement props
  List<Object?> get props => [topRatedTvSeries];
}

class TopRatedTvSeriesError extends TopRatedTvSeriesState {
  final String errMessage;
  final Function() tryAgain;

  TopRatedTvSeriesError(this.errMessage, { required this.tryAgain});

  @override
  // TODO: implement props
  List<Object?> get props => [errMessage];
}