import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

///
/// Created by handy on 24/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent,TopRatedMovieState> {

  TopRatedMovieBloc(GetTopRatedMovies getTopRatedMovies) : super(TopRatedMovieInit()){
    on<TopRatedMovieEvent>((event, emit) async {
      emit(TopRatedMovieIsLoading());

      final result = await getTopRatedMovies.execute();
      result.fold((failure) {
        final state = TopRatedMovieError(failure.message, tryAgain: () {
          add(OnTopRatedMovieTask());
        });

        emit(state);

      }, (data) {
        final state = TopRatedMovieLoaded(data);
        emit(state);

      });
    });
  }

}
 

