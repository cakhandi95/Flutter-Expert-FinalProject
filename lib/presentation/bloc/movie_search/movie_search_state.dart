part of 'movie_search_bloc.dart';

///
/// Created by handy on 22/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class MovieSearchInit extends MovieSearchState { }

class MovieSearchIsLoading extends MovieSearchState { }

class MovieSearchEmpty extends MovieSearchState {
  final String emptyMessage;

  MovieSearchEmpty(this.emptyMessage);
}

class MovieSearchLoaded extends MovieSearchState {
  final List<Movie> searchResult;

  MovieSearchLoaded(this.searchResult);

  @override
  // TODO: implement props
  List<Object?> get props => [searchResult];
}

class MovieSearchError extends MovieSearchState {
  final String errMessage;
  final Function? tryAgain;

  MovieSearchError(this.errMessage, { required this.tryAgain});

  @override
  // TODO: implement props
  List<Object?> get props => [errMessage, tryAgain != null];
}
