import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recomendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

///
/// Created by handy on 23/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

class TvSeriesDetailBloc extends Bloc<TvSeriesDetailEvent,TvSeriesDetailState> {

  TvSeriesDetailBloc(GetTVSeriesDetail getTVSeriesDetail,GetTVSeriesRecommendations getTVSeriesRecommendations) : super(TvSeriesDetailInit()) {
    on<TvSeriesDetailEvent>((event, emit) async {
      if(event is IdTvSeriesDetailResult) {
        onTvSeriesDetailResultData(getTVSeriesDetail, getTVSeriesRecommendations, event.id,emit);
      }
    });
  }

  Future<void> onTvSeriesDetailResultData(
      GetTVSeriesDetail getTVSeriesDetail,
      GetTVSeriesRecommendations getTVSeriesRecommendations,
      int id,
      emit) async {
    emit(TvSeriesDetailIsLoading());
    final detailResult = await getTVSeriesDetail.execute(id);
    final recommendationResult = await getTVSeriesRecommendations.execute(id);

    detailResult.fold((failure) {
      final state = TvSeriesDetailError(failure.message, tryAgain: () {
        add(IdTvSeriesDetailResult(id));
      });

      emit(state);
    }, (tvseries) {
      recommendationResult.fold((failure) {
        final state = TvSeriesDetailError(failure.message, tryAgain: () {
          add(OnTvSeriesRecommendationResult(tvseries));
        });
        emit(state);
      }, (movies) {
        final successState = TvSeriesDetailLoaded(tvseries, recommendations: movies);
        emit(successState);
      });
    });
  }
}
 

