import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries_episode.dart';
import 'package:ditonton/domain/usecases/get_episode_tvseries.dart';
import 'package:flutter/foundation.dart';

class EpisodeTVSeriesNotifier extends ChangeNotifier {
  final GetEpisodeTVSeries getEpisodeTVSeries;

  EpisodeTVSeriesNotifier(this.getEpisodeTVSeries);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TVSeriesEpisode> _tvseries = [];
  List<TVSeriesEpisode> get tvseries => _tvseries;

  String _message = '';
  String get message => _message;

  Future<void> fetchEpisodeTVSeries(int id,int season) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getEpisodeTVSeries.execute(id,season);

    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (tvseriesData) {
        _tvseries = tvseriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
