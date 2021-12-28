part of 'now_playing_movie_bloc.dart';

///
/// Created by handy on 24/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

abstract class NowPlayingMovieState extends Equatable {

  const NowPlayingMovieState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NowPlayingMovieInit extends NowPlayingMovieState {  }

class NowPlayingMovieIsLoading extends NowPlayingMovieState { }

class NowPlayingMovieLoaded extends NowPlayingMovieState {

  final List<Movie> movies;

  NowPlayingMovieLoaded(this.movies);

  @override
  // TODO: implement props
  List<Object?> get props => [movies];
}

class NowPlayingMovieError extends NowPlayingMovieState {
  final String errMessage;
  final Function tryAgain;

  NowPlayingMovieError(this.errMessage, {required this.tryAgain});

  @override
  // TODO: implement props
  List<Object?> get props => [errMessage];
}