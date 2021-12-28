/// 
/// Created by handy on 23/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

part of 'watchlist_bloc.dart';

abstract class WatchListEvent extends Equatable {
  const WatchListEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class OnWatchListDataTask extends WatchListEvent { }

 

