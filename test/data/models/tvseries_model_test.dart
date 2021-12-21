import 'package:ditonton/data/models/tvseries_episode_model.dart';
import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_episode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTVSeriesEpisodeModel = TVSeriesEpisodeModel(
      air_date: "2021-11-16",
      id: 1,
      still_path: "/btxoq1RGpcnEBmqAra5yFU63VCS.jpg",
      name: "Armageddon",
      overview: "When",
      vote_average: 8.5,
      vote_count: 2
  );

  final tTVSeriesEpisode = TVSeriesEpisode(
      air_date: "2021-11-16",
      id: 1,
      still_path: "/btxoq1RGpcnEBmqAra5yFU63VCS.jpg",
      name: "Armageddon",
      overview: "When",
      vote_average: 8.5,
      vote_count: 2
  );

  final tTVSeriesModel = TVSeriesModel(
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

  final tTVSeries = TVSeries(
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

  test('should be a subclass of TVSeries entity', () async {
    final result = tTVSeriesModel.toEntity();
    expect(result, tTVSeries);
  });


  test('should be a subclass of TVSeries Episode entity', () async {
    final result = tTVSeriesEpisodeModel.toEntity();
    expect(result, tTVSeriesEpisode);
  });
}
