part of 'tvseries_search_bloc.dart';

///
/// Created by handy on 22/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

class TvSeriesSearchState extends Equatable {

  const TvSeriesSearchState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvSeriesSearchInit extends TvSeriesSearchState { }

class TvSeriesSearchIsLoading extends TvSeriesSearchState { }

class TvSeriesSearchLoaded extends TvSeriesSearchState {

  final List<TVSeries> tvSeriesLoaded;

  TvSeriesSearchLoaded(this.tvSeriesLoaded);

  @override
  // TODO: implement props
  List<Object?> get props => [tvSeriesLoaded];

}

class TvSeriesSearchEmpty extends TvSeriesSearchState {

  final String errMessage;

  TvSeriesSearchEmpty(this.errMessage);
}

class TvSeriesSearchError extends TvSeriesSearchState {
  final String errMessage;
  final Function tryAgain;

  TvSeriesSearchError(this.errMessage, {required this.tryAgain});
}