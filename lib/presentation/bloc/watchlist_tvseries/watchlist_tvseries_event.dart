import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';

///
/// Created by handy on 28/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

abstract class WatchListTvSeriesEvent extends Equatable {

  const WatchListTvSeriesEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnWatchListTvSeriesRequest extends WatchListTvSeriesEvent {}