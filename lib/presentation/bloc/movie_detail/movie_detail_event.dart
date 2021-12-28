part of 'movie_detail_bloc.dart';

///
/// Created by handy on 22/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

abstract class MovieDetailEvent extends Equatable {

  const MovieDetailEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnMovieDetailDataRequested extends MovieDetailEvent {

  final int id;

  OnMovieDetailDataRequested(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];

}

class OnMovieRecommendationRequested extends MovieDetailEvent {
  final MovieDetail movieDetail;

  OnMovieRecommendationRequested(this.movieDetail);

  @override
  // TODO: implement props
  List<Object?> get props => [movieDetail];
}