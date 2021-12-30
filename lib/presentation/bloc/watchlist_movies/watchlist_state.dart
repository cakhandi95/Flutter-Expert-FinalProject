/// 
/// Created by handy on 23/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

part of 'watchlist_bloc.dart';

abstract class WatchListState extends Equatable {
  const WatchListState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WatchListInit extends WatchListState { }

class WatchListIsLoading extends WatchListState { }

class WatchListEmpty extends WatchListState { }

class WatchListLoaded extends WatchListState {

  final List<Movie> watchlistMovies;

  WatchListLoaded(this.watchlistMovies);

  @override
  // TODO: implement props
  List<Object?> get props => [...watchlistMovies];
}

class WatchListError extends WatchListState {

  final String errMessage;
  final Function tryAgain;

  WatchListError(this.errMessage, {required this.tryAgain});

  @override
  // TODO: implement props
  List<Object?> get props => [errMessage];
}