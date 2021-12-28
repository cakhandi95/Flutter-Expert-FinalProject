part of 'tvseries_search_bloc.dart';

///
/// Created by handy on 22/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

class TvSeriesSearchEvent extends Equatable {

  const TvSeriesSearchEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class SearchTvSeriesOnQueryChanged extends TvSeriesSearchEvent {

  final String keywords;

  SearchTvSeriesOnQueryChanged(this.keywords);

  @override
  // TODO: implement props
  List<Object?> get props => [keywords];

}