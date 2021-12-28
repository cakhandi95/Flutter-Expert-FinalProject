import 'package:ditonton/domain/usecases/get_episode_tvseries.dart';
import 'package:ditonton/presentation/bloc/episode_tvseries/episode_tvseries_event.dart';
import 'package:ditonton/presentation/bloc/episode_tvseries/episode_tvseries_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// Created by handy on 28/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

class EpisodeTvSeriesBloc extends Bloc<EpisodeTvSeriesEvent,EpisodeTvSeriesState> {
  EpisodeTvSeriesBloc(GetEpisodeTVSeries getEpisodeTVSeries) : super(EpisodeTvSeriesInit()){
    on<EpisodeTvSeriesEvent>((event, emit) {
      if (event is EpisodeTvSeriesRequestData) {
        episodeTvSeriesRequestData(getEpisodeTVSeries, event.id, event.season, emit);
      }
    });
  }

  Future <void> episodeTvSeriesRequestData(GetEpisodeTVSeries getEpisodeTVSeries, int id, int season,emit) async {
    emit(EpisodeTvSeriesIsLoading());

    final result = await getEpisodeTVSeries.execute(id, season);

    result.fold((failure) {
      final state = EpisodeTvSeriesError(failure.message, tryAgain: () {
        add(EpisodeTvSeriesRequestData(id: id, season: season));
      });

      emit(state);

    }, (episode) {
      final state = EpisodeTvSeriesLoaded(episode);
      emit(state);
    });
  }

}