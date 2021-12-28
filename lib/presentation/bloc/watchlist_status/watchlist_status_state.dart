part of 'watchlist_status_bloc.dart';

///
/// Created by handy on 23/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

abstract class WatchListStatusState extends Equatable {

  const WatchListStatusState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WatchListStatusInit extends WatchListStatusState { }

class WatchListStatusIsLoading extends WatchListStatusState { }

class WatchListStatusLoad extends WatchListStatusState {
  final bool isLoad;

  WatchListStatusLoad(this.isLoad);

  @override
  List<Object> get props => [isLoad];
}

class WatchListStatusError extends WatchListStatusState {
  final String errMessage;
  final Function tryAgain;

  WatchListStatusError(this.errMessage, {required this.tryAgain});

  @override
  List<Object> get props => [errMessage];
}

class WatchlistStatusSuccess extends WatchListStatusState {
  final String message;

  WatchlistStatusSuccess(this.message);

  @override
  List<Object> get props => [message];
}