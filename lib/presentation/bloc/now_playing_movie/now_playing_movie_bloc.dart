import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

///
/// Created by handy on 24/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

class NowPlayingMovieBloc extends Bloc<
    NowPlayingMovieEvent,
    NowPlayingMovieState
> {
  NowPlayingMovieBloc(GetNowPlayingMovies getNowPlayingMovies) : super(NowPlayingMovieInit()) {
    on<NowPlayingMovieEvent>((event, emit) {
      if (event is OnNowPlayingMovieDataTask) {
        onNowPlayingMovieDataTask(getNowPlayingMovies, emit);
      }
    });
  }

  Future <void> onNowPlayingMovieDataTask(
      GetNowPlayingMovies getNowPlayingMovies,
      emit) async {
    emit(NowPlayingMovieIsLoading());

    final result = await getNowPlayingMovies.execute();

    result.fold((failure) {
      final state = NowPlayingMovieError(failure.message, tryAgain: () {
        add(OnNowPlayingMovieDataTask());
      });

      emit(state);
    }, (data) {
      final state = NowPlayingMovieLoaded(data);
      emit(state);
    });
  }
}
 

