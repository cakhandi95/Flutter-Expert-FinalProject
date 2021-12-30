part of 'on_the_air_tvseries_bloc.dart';

///
/// Created by handy on 24/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

abstract class OnTheAirTvSeriesState extends Equatable {
  const OnTheAirTvSeriesState();

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class OnTheAirTvSeriesInit extends OnTheAirTvSeriesState { }

class OnTheAirTvSeriesIsLoading extends OnTheAirTvSeriesState { }

class OnTheAirTvSeriesLoaded extends OnTheAirTvSeriesState {

  final List<TVSeries> onTheAirTVSeries;

  OnTheAirTvSeriesLoaded(this.onTheAirTVSeries);

  @override
  List<Object> get props => [onTheAirTVSeries];
}

class OnTheAirTvSeriesError extends OnTheAirTvSeriesState {
  final String errMessage;
  final Function tryAgain;

  OnTheAirTvSeriesError(this.errMessage, {required this.tryAgain});

  @override
  // TODO: implement props
  List<Object?> get props => [errMessage];
}
