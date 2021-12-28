import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/src/transformers/backpressure/debounce.dart';
import 'package:rxdart/src/transformers/flat_map.dart';

part 'tvseries_search_event.dart';
part 'tvseries_search_state.dart';

///
/// Created by handy on 22/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

class TvSeriesSearchBloc extends Bloc<TvSeriesSearchEvent,TvSeriesSearchState> {

  TvSeriesSearchBloc(SearchTVSeries searchTVSeries) : super(TvSeriesSearchInit()) {
    on<TvSeriesSearchEvent>((event, emit) async {
      if (event is SearchTvSeriesOnQueryChanged) {
        final keywords = event.keywords;

        if(keywords.length == 0) {
          emit(TvSeriesSearchInit());
          return;
        }

        emit(TvSeriesSearchIsLoading());

        final result = await searchTVSeries.execute(keywords);

        result.fold((failure) {
          final resultFailed = TvSeriesSearchError(failure.message, tryAgain: () {
            add(SearchTvSeriesOnQueryChanged(keywords));
          });
          emit(resultFailed);
        }, (data) async {
          if (data.length > 0) {
            final resultSuccess = TvSeriesSearchLoaded(data);
            emit(resultSuccess);
          } else {
            emit(TvSeriesSearchEmpty('TV Series Not Found'));
          }
        });
      }
    }, transformer: (events,mapper) => events.debounceTime(const Duration(microseconds: 900)).flatMap(mapper));
  }
}