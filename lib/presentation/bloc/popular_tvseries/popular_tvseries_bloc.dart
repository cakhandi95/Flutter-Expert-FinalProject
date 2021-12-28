import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_tvseries_event.dart';
part 'popular_tvseries_state.dart';

///
/// Created by handy on 24/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

class PopularTvSeriesBloc extends Bloc<PopulerTvSeriesEvent,PopulerTvSeriesState> {

  PopularTvSeriesBloc(GetPopularTVSeries getPopularTVSeries) : super(PopularTvSeriesInit()){
    on<PopulerTvSeriesEvent>((event, emit) async {
      emit(PopularTvSeriesIsLoading());

      final result = await getPopularTVSeries.execute();

      result.fold((failure) {
        final state = PopularTvSeriesError(failure.message, tryAgain: () {
          add(OnPopulerTvSeriesTask());
        });

        emit(state);
      }, (data) {
        final state = PopularTvSeriesLoaded(data);
        emit(state);
      });
    });

  }

}

