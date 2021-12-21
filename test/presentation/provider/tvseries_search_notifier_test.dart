import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:ditonton/presentation/provider/tvseries_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvseries_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late TVSeriesSearchNotifier provider;
  late MockSearchTVSeries mockSearchTVSeriess;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTVSeriess = MockSearchTVSeries();
    provider = TVSeriesSearchNotifier(searchTVSeries: mockSearchTVSeriess)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTVSeriesModel = TVSeries(
      backdrop_path: "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
      first_air_date: "2021-10-12",
      genre_ids: [
        1,
        2,
        3
      ],
      id: 1,
      name: "Chucky",
      origin_country: [
        "US"
      ],
      original_name: "Chucky",
      overview: "After a",
      popularity: 5154.752,
      poster_path: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
      vote_average: 8,
      vote_count: 2356
  );
  final tTVSeriesList = <TVSeries>[tTVSeriesModel];
  final tQuery = 'Chucky';

  group('search tvseries', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTVSeriess.execute(tQuery))
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchTVSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTVSeriess.execute(tQuery))
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      await provider.fetchTVSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTVSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTVSeriess.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTVSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
