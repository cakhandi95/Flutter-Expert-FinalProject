import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries_episode.dart';
import 'package:ditonton/domain/usecases/get_episode_tvseries.dart';
import 'package:ditonton/presentation/provider/tvseries_episode_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'episode_tvseries_notifier_test.mocks.dart';

@GenerateMocks([GetEpisodeTVSeries])
void main() {
  late MockGetEpisodeTVSeries mockGetEpisodeTVSeries;
  late EpisodeTVSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetEpisodeTVSeries = MockGetEpisodeTVSeries();
    notifier = EpisodeTVSeriesNotifier(mockGetEpisodeTVSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });


  final tTVSeriesEpisode = TVSeriesEpisode(
      air_date: "2021-11-16",
      id: 1,
      still_path: "/btxoq1RGpcnEBmqAra5yFU63VCS.jpg",
      name: "Armageddon",
      overview: "When",
      vote_average: 8.5,
      vote_count: 2
  );

  final tTVSeriesEpisodeList = <TVSeriesEpisode>[tTVSeriesEpisode];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetEpisodeTVSeries.execute(1,8))
        .thenAnswer((_) async => Right(tTVSeriesEpisodeList));
    // act
    notifier.fetchEpisodeTVSeries(1, 8);
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetEpisodeTVSeries.execute(1,8))
        .thenAnswer((_) async => Right(tTVSeriesEpisodeList));
    // act
    await notifier.fetchEpisodeTVSeries(1, 8);
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvseries, tTVSeriesEpisodeList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetEpisodeTVSeries.execute( 1,8))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchEpisodeTVSeries(1, 8);
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
