import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/src/transformers/backpressure/debounce.dart';
import 'package:rxdart/src/transformers/flat_map.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

///
/// Created by handy on 22/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

class MovieSearchBloc extends Bloc<MovieSearchEvent,MovieSearchState> {

  MovieSearchBloc(SearchMovies searchMovies) : super(MovieSearchInit()) {
    on<MovieSearchEvent>((event, emit) async {
      if (event is SearchMovieOnQueryChanged) {
        final keywords = event.keywords;

        if (keywords.length == 0) {
          emit(MovieSearchInit());
          return;
        }

        emit(MovieSearchIsLoading());

        final result = await searchMovies.execute(keywords);

        result.fold((failure) {
          final resultFailed = MovieSearchError('Server Failure', tryAgain: () {
            add(SearchMovieOnQueryChanged(keywords));
          });

          emit(resultFailed);

        }, (data) async {
          if(data.length > 0) {
            final resultSuccess = MovieSearchLoaded(data);
            emit(resultSuccess);
          } else {
            emit(MovieSearchEmpty('Movie Not Found'));
          }
        });
      }
    }, transformer: (events,mapper) => events.debounceTime(const Duration(microseconds: 900)).flatMap(mapper));
  }
}

