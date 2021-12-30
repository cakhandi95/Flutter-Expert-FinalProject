part of 'popular_movies_bloc.dart';
///
/// Created by handy on 24/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

abstract class PopularMovieEvent extends Equatable {
  const PopularMovieEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class OnPopularMovieTask extends PopularMovieEvent { }

