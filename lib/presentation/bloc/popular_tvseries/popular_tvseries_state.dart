part of 'popular_tvseries_bloc.dart';

///
/// Created by handy on 24/12/21
/// HP Probook G1 430
/// handikadwiputradev@gmail.com
///

abstract class PopulerTvSeriesState extends Equatable {
  const PopulerTvSeriesState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PopularTvSeriesInit extends PopulerTvSeriesState { }

class PopularTvSeriesIsLoading extends PopulerTvSeriesState { }

class PopularTvSeriesLoaded extends PopulerTvSeriesState {
  final List<TVSeries> popularTvSeries;

  PopularTvSeriesLoaded(this.popularTvSeries);

  @override
  List<Object> get props => [popularTvSeries];
}

class PopularTvSeriesError extends PopulerTvSeriesState {
  final String errMessage;
  final Function() tryAgain;

  PopularTvSeriesError(this.errMessage, {required this.tryAgain});

  @override
  // TODO: implement props
  List<Object?> get props => [errMessage];
}