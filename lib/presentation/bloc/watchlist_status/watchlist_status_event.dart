part of 'watchlist_status_bloc.dart';

///
/// Created by handy on 23/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

abstract class WatchlistStatusEvent extends Equatable {

  const WatchlistStatusEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnListWatchAdd extends WatchlistStatusEvent {
  final MovieDetail movieDetail;

  OnListWatchAdd(this.movieDetail);

  @override
  // TODO: implement props
  List<Object?> get props => [movieDetail];
}

class OnListWatchRemoved extends WatchlistStatusEvent {
  final MovieDetail movieDetail;

  OnListWatchRemoved(this.movieDetail);

  List<Object> get props => [movieDetail];
}

class OnListTvSeriesRemoved extends WatchlistStatusEvent {
  final TVSeriesDetail tvSeriesDetail;

  OnListTvSeriesRemoved(this.tvSeriesDetail);

  @override
  // TODO: implement props
  List<Object?> get props => [tvSeriesDetail];
}


class OnListTvSeriesAdded extends WatchlistStatusEvent {
  final TVSeriesDetail tvSeriesDetail;

  OnListTvSeriesAdded(this.tvSeriesDetail);

  @override
  // TODO: implement props
  List<Object?> get props => [tvSeriesDetail];
}


