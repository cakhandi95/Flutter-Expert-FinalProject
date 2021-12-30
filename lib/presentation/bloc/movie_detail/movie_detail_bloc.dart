import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

/// Created by handy on 22/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com

class MovieDetailBloc extends Bloc<MovieDetailEvent,MovieDetailState> {

  MovieDetailBloc(
      GetMovieDetail getMovieDetail,
      GetMovieRecommendations getMovieRecommendations,
      GetWatchListStatus getWatchListStatus) : super(MovieDetailInit()) {
    on<MovieDetailEvent>((event, emit) => {
      if (event is OnMovieDetailDataRequested) {
        fetchMovieDetail(
            event.id,
            getMovieDetail,
            getMovieRecommendations,
            getWatchListStatus,
            emit
        )
      }
    });
  }

  Future<void> fetchMovieDetail(int id,GetMovieDetail getMovieDetail,
      GetMovieRecommendations getMovieRecommendations,
      GetWatchListStatus getWatchListStatus,
      emit) async {

    emit(MovieDetailIsLoading());

    final detailResult = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);
    final isCheckedWatchList = await getWatchListStatus.execute(id);

    detailResult.fold(
          (failure) {
        final state = MovieDetailError(failure.message, tryAgain: () {
          add(OnMovieDetailDataRequested(id));
        });
        emit(state);
      }, (movie) {
      emit(MovieDetailIsLoading());
      final movieDetail = movie;
      recommendationResult.fold((failure) async {
        final state = MovieDetailError(failure.message, tryAgain: () {
          add(OnMovieRecommendationRequested(id));
        });
        emit(state);
      }, (movies) {
        final state = MovieDetailLoaded(movieDetail,isCheckedWatchList, recommendations: movies);
        emit(state);
      },);},);
  }
}