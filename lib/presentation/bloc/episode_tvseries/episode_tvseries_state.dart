import 'package:ditonton/domain/entities/tvseries_episode.dart';
import 'package:equatable/equatable.dart';

///
/// Created by handy on 28/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

class EpisodeTvSeriesState extends Equatable {

  const EpisodeTvSeriesState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EpisodeTvSeriesIsLoading extends EpisodeTvSeriesState { }

class EpisodeTvSeriesInit extends EpisodeTvSeriesState { }

class EpisodeTvSeriesError extends EpisodeTvSeriesState {
  final Function tryAgain;
  final String errMessage;

  EpisodeTvSeriesError(this.errMessage, {required this.tryAgain});
}

class EpisodeTvSeriesLoaded extends EpisodeTvSeriesState {

  final List<TVSeriesEpisode> tvSeriesEpisode;

  EpisodeTvSeriesLoaded(this.tvSeriesEpisode);
}