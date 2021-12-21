import 'dart:convert';

import 'package:ditonton/data/models/tvseries_episode_model.dart';
import 'package:ditonton/data/models/tvseries_episode_response.dart';
import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:ditonton/data/models/tvseries_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

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

  final tTVSeriesEpisodeResponseModel =
  TVSeriesEpisodeResponse(tvseriesEpisodeList: <TVSeriesEpisodeModel>[tTVSeriesEpisodeModel]);
  group('Episode fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/tvseries_episode.json'));
      // act
      final result = TVSeriesEpisodeResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVSeriesEpisodeResponseModel);
    });
  });


  group('Episode toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVSeriesEpisodeResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "episodes": [
          {
            "air_date": "2021-11-16",
            "id": 1,
            "name": "Armageddon",
            "overview": "When",
            "still_path": "/btxoq1RGpcnEBmqAra5yFU63VCS.jpg",
            "vote_average": 8.5,
            "vote_count": 2
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });

  final tTVSeriesResponseModel =
  TVSeriesResponse(tvseriesList: <TVSeriesModel>[tTVSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/on_the_air.json'));
      // act
      final result = TVSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
            "first_air_date": "2021-10-12",
            "genre_ids": [
              1,
              2,
              3
            ],
            "id": 1,
            "name": "Chucky",
            "origin_country": [
              "US"
            ],
            "original_name": "Chucky",
            "overview": "After a",
            "popularity": 5154.752,
            "poster_path": "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
            "vote_average": 8,
            "vote_count": 2356
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
