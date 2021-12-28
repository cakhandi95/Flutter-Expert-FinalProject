import 'package:ditonton/domain/usecases/get_watchlist_tvseries.dart';
import 'package:ditonton/presentation/bloc/watchlist_tvseries/watchlist_tvseries_event.dart';
import 'package:ditonton/presentation/bloc/watchlist_tvseries/watchlist_tvseries_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// Created by handy on 28/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

class WatchlistTvSeriesBloc extends Bloc <WatchListTvSeriesEvent,WatchListTvSeriesState> {

  WatchlistTvSeriesBloc(GetWatchlistTVSeries getWatchlistTVSeries) : super(WatchListTvSeriesInit()) {
    on<WatchListTvSeriesEvent>((event, emit) {
      if (event is OnWatchListTvSeriesRequest) {
        onWatchListTvSeriesRequest(getWatchlistTVSeries, emit);
      }
    });
  }

  Future <void> onWatchListTvSeriesRequest(GetWatchlistTVSeries getWatchlistTVSeries, dynamic emit) async {

    emit(WatchListTvSeriesIsLoading());

    final result = await getWatchlistTVSeries.execute();

    result.fold((failure) {
      final resultError = WatchListTvSeriesError(failure.message, tryAgain: () {
        add(OnWatchListTvSeriesRequest());
      });
      emit(resultError);
    }, (tvSeries) {
      final result = WatchListTvSeriesLoaded(tvSeries);
      emit(result);
    });

  }

}

