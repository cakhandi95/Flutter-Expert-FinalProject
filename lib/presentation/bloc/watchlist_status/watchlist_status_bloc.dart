import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tvseries.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/watchlist_movies/watchlist_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_status_event.dart';
part 'watchlist_status_state.dart';

///
/// Created by handy on 23/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

class WatchListStatusBloc extends Bloc<WatchlistStatusEvent,WatchListStatusState> {

  WatchListStatusBloc(
      WatchListBloc watchlistBloc,
      GetWatchListStatus getWatchListStatus,
      GetWatchListStatusTVSeries getWatchListStatusTVSeries,
      SaveWatchlist saveWatchlist,
      RemoveWatchlist removeWatchlist
      ) : super(WatchListStatusInit()) {
    on<WatchlistStatusEvent>((event, emit) async {
      if (event is OnListWatchAdd) {
        addWatchlist(saveWatchlist,getWatchListStatus, event.movieDetail, emit);
      } else if (event is OnListWatchRemoved) {
        removeFromWatchlist(getWatchListStatus, removeWatchlist, event.movieDetail, emit);
      }
    });
  }

  Future<void> addWatchlist(
      SaveWatchlist saveWatchlist,
      GetWatchListStatus getWatchListStatus,
      MovieDetail movieDetail, emit) async {
    final result = await saveWatchlist.execute(movieDetail);
    emit(WatchListStatusIsLoading());

    await result.fold((failure) async {
      final state = WatchListStatusError(failure.message, tryAgain: () {
        add(OnListWatchAdd(movieDetail));
      });
      emit(state);
    }, (successMessage) async {
      final state = WatchlistStatusSuccess(
          'Success Added ${movieDetail.title} to watchlist');
      emit(state);
    },);
    await onListWatchChecked(getWatchListStatus, movieDetail.id,emit);
  }

  Future<void> removeFromWatchlist(GetWatchListStatus getWatchListStatus, RemoveWatchlist removeWatchlist, MovieDetail movieDetail,emit) async {
    final result = await removeWatchlist.execute(movieDetail);
    emit(WatchListStatusIsLoading());

    await result.fold((failure) async {
      final state = WatchListStatusError(failure.message, tryAgain: () {
        add(OnListWatchRemoved(movieDetail));
      });
      emit(state);
    }, (successMessage) async {
      final state = WatchlistStatusSuccess('Success Removed');
      emit(state);
    },);

    await onListWatchChecked(getWatchListStatus,movieDetail.id,emit);
  }

  Future<void> onListWatchChecked(GetWatchListStatus getWatchListStatus, int id,emit) async {
    final result = await getWatchListStatus.execute(id);
    emit(WatchListStatusLoad(result));
  }

}
