import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_movie_state.dart';
part 'popular_movie_event.dart';

///
/// Created by handy on 24/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

class PopularMovieBloc extends Bloc<PopularMovieEvent,PopularMovieState> {

  PopularMovieBloc(GetPopularMovies getPopularMovies) : super(PopularMovieInit()) {
    on<PopularMovieEvent>((event, emit) async {
      emit(PopularMovieIsLoading());
      final result = await getPopularMovies.execute();

      result.fold((failure) {
        final state = PopularMovieError(failure.message, tryAgain: () {
          add(OnPopularMovieTask());
        });

        emit(state);
      }, (data) {
        final state = PopularMovieLoaded(data);
        emit(state);
      });
    });
  }

}

