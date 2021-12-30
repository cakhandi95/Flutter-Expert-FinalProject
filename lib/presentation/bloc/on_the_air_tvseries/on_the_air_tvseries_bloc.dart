import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'on_the_air_tvseries_state.dart';
part 'on_the_air_tvseries_event.dart';

///
/// Created by handy on 24/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

class OnTheAirTvSeriesBloc extends Bloc<OnTheAirTvSeriesEvent,OnTheAirTvSeriesState> {

  OnTheAirTvSeriesBloc(GetOnTheAirTVSeries getOnTheAirTVSeries) : super(OnTheAirTvSeriesInit()) {
    on<OnTheAirTvSeriesEvent>((event, emit) async {
      emit(OnTheAirTvSeriesIsLoading());
      final result = await getOnTheAirTVSeries.execute();
      result.fold((failure) {
        final state = OnTheAirTvSeriesError(failure.message, tryAgain: () {
          add(OnTheAirTvSeriesTask());
        });

        emit(state);
      }, (data) {
        final state = OnTheAirTvSeriesLoaded(data);
        emit(state);
      });
    });
  }

}

