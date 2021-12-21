import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_episode.dart';
import 'package:ditonton/domain/usecases/get_episode_tvseries.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetEpisodeTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRpository;

  setUp(() {
    mockTVSeriesRpository = MockTVSeriesRepository();
    usecase = GetEpisodeTVSeries(mockTVSeriesRpository);
  });

  final tTVSeriesEpisode = <TVSeriesEpisode>[];

  group('Get Popular TVSeries Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockTVSeriesRpository.getEpisode(1, 8))
            .thenAnswer((_) async => Right(tTVSeriesEpisode));
        // act
        final result = await usecase.execute(1,8);
        // assert
        expect(result, Right(tTVSeriesEpisode));
      });
    });
  });
}
