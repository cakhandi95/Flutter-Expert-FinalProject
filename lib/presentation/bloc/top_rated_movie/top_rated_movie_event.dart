part of 'top_rated_movie_bloc.dart';

///
/// Created by handy on 24/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

abstract class TopRatedMovieEvent extends Equatable {
  const TopRatedMovieEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnTopRatedMovieTask extends TopRatedMovieEvent { }

