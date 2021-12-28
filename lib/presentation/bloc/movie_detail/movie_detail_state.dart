part of 'movie_detail_bloc.dart';


///
/// Created by handy on 22/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

class MovieDetailState extends Equatable {

  const MovieDetailState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MovieDetailInit extends MovieDetailState { }

class MovieDetailLoaded extends MovieDetailState {

  final MovieDetail movieDetail;
  final List<Movie> recommendations;

  MovieDetailLoaded(this.movieDetail, {this.recommendations = const[]});
}

class MovieDetailError extends MovieDetailState {

  final Function tryAgain;
  final String errMessage;

  MovieDetailError(this.errMessage, {
    required this.tryAgain
  });
}

class MovieDetailIsLoading extends MovieDetailState {  }

