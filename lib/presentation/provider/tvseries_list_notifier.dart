import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvseries.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:flutter/material.dart';

class TVSeriesListNotifier extends ChangeNotifier {
  var _onTheAirTVSeries = <TVSeries>[];
  List<TVSeries> get onTheAirTVSeries => _onTheAirTVSeries;

  RequestState _onTheAirTVSeriesState = RequestState.Empty;
  RequestState get onTheAirTVSeriesState => _onTheAirTVSeriesState;

  var _popularTVSeries = <TVSeries>[];
  List<TVSeries> get popularTVSeries => _popularTVSeries;

  RequestState _popularTVSeriesState = RequestState.Empty;
  RequestState get popularTVSeriesState => _popularTVSeriesState;

  var _topRatedTVSeries = <TVSeries>[];
  List<TVSeries> get topRatedTVSeries => _topRatedTVSeries;

  RequestState _topRatedTVSeriesState = RequestState.Empty;
  RequestState get topRatedTVSeriesState => _topRatedTVSeriesState;

  String _message = '';
  String get message => _message;

  TVSeriesListNotifier({
    required this.getOnTheAirTVSeries,
    required this.getPopularTVSeries,
    required this.getTopRatedTVSeries,
  });

  final GetOnTheAirTVSeries getOnTheAirTVSeries;
  final GetPopularTVSeries getPopularTVSeries;
  final GetTopRatedTVSeries getTopRatedTVSeries;

  Future<void> fetchGetOnTheAir() async {
    _onTheAirTVSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTVSeries.execute();
    result.fold(
          (failure) {
            _onTheAirTVSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (tvSeriesData) {
            _onTheAirTVSeriesState = RequestState.Loaded;
            _onTheAirTVSeries = tvSeriesData;
            notifyListeners();
            },
    );
  }

  Future<void> fetchGetPopular() async {
    _popularTVSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTVSeries.execute();
    result.fold(
          (failure) {
        _popularTVSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (tvSeriesData) {
        _popularTVSeriesState = RequestState.Loaded;
        _popularTVSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchGetTopRated() async {
    _topRatedTVSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTVSeries.execute();
    result.fold(
          (failure) {
            _topRatedTVSeriesState = RequestState.Error;
            _message = failure.message;
            notifyListeners();
      },
          (tvSeriesData) {
            _topRatedTVSeriesState = RequestState.Loaded;
            _topRatedTVSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
