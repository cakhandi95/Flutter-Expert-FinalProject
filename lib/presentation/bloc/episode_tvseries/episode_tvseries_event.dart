import 'package:equatable/equatable.dart';

///
/// Created by handy on 28/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

abstract class EpisodeTvSeriesEvent extends Equatable {

  const EpisodeTvSeriesEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class EpisodeTvSeriesRequestData extends EpisodeTvSeriesEvent {

  final int id;
  final int season;

  EpisodeTvSeriesRequestData({required this.id,required this.season});

}
