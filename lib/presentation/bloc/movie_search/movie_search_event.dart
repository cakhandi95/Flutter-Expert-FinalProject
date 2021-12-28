part of 'movie_search_bloc.dart';

///
/// Created by handy on 22/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchMovieOnQueryChanged extends MovieSearchEvent {

  final String keywords;

  SearchMovieOnQueryChanged(this.keywords);

  @override
  // TODO: implement props
  List<Object?> get props => [keywords];
}

