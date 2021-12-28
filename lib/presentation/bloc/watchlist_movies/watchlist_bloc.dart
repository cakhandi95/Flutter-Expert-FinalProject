import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'watchlist_state.dart';
part 'watchlist_event.dart';

class WatchListBloc extends Bloc<WatchListEvent,WatchListState> {

  WatchListBloc(GetWatchlistMovies getWatchlistMovies) : super(WatchListInit()) {
    on<WatchListEvent>((event, emit) {
      if (event is OnWatchListDataTask) {
        onWatchListDataTask(getWatchlistMovies, emit);
      }
    });
  }



  Future<void> onWatchListDataTask (GetWatchlistMovies getWatchlistMovies,emit) async {
    emit(WatchListIsLoading());

    final result = await getWatchlistMovies.execute();

    result.fold((failure) {

      final state = WatchListError(failure.message, tryAgain: () {
        add(OnWatchListDataTask());
      });

      emit(state);
    }, (data) {
      if (data.length == 0) {
        emit(WatchListEmpty());
        return;
      }

      emit(WatchListLoaded(data));
    });
  }



}

