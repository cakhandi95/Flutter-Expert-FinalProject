part of 'top_rated_movie_bloc.dart';
///
/// Created by handy on 24/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

abstract class TopRatedMovieState extends Equatable {

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class TopRatedMovieInit extends TopRatedMovieState { }

class TopRatedMovieIsLoading extends TopRatedMovieState { }

class TopRatedMovieLoaded extends TopRatedMovieState {

  final List<Movie> topRatedMovies;

  TopRatedMovieLoaded(this.topRatedMovies);

  @override
  // TODO: implement props
  List<Object?> get props => [topRatedMovies];

}

class TopRatedMovieError extends TopRatedMovieState {

  final String errMessage;
  final Function tryAgain;

  TopRatedMovieError(this.errMessage, {required this.tryAgain});

}