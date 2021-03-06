part of 'popular_movies_bloc.dart';

///
/// Created by handy on 24/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PopularMovieInit extends PopularMovieState { }

class PopularMovieIsLoading extends PopularMovieState { }

class PopularMovieLoaded extends PopularMovieState {

  final List<Movie> popularMovies;

  PopularMovieLoaded(this.popularMovies);

  @override
  // TODO: implement props
  List<Object?> get props => [popularMovies];
}

class PopularMovieError extends PopularMovieState {

  final String errMessage;
  final Function tryAgain;

  PopularMovieError(this.errMessage, {required this.tryAgain});

  @override
  // TODO: implement props
  List<Object?> get props => [errMessage];
}

