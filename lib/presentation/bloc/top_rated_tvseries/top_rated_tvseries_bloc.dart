import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_tvseries_state.dart';
part 'top_rated_tvseries_event.dart';

///
/// Created by handy on 24/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

class TopRatedTvSeriesBloc extends Bloc<TopRatedTvSeriesEvent,TopRatedTvSeriesState> {

  TopRatedTvSeriesBloc(GetTopRatedTVSeries getTopRatedTvSeries) : super(TopRatedTvSeriesInit()){
    on<TopRatedTvSeriesEvent>((event, emit) async {
      emit(TopRatedTvSeriesIsLoading());
      final result = await getTopRatedTvSeries.execute();

      result.fold((failure) {
        final state = TopRatedTvSeriesError(failure.message, tryAgain: () {
          add(TopRatedTvSeriesTask());
        });

        emit(state);
      }, (data) {
        final state = TopRatedTvSeriesLoaded(data);
        emit(state);
      });
    });
  }

}

 

