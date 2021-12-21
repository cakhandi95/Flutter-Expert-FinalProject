import 'dart:convert';

import 'package:ditonton/data/datasources/tvseries_remote_data_source.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tvseries_detail_model.dart';
import 'package:ditonton/data/models/tvseries_episode_response.dart';
import 'package:ditonton/data/models/tvseries_response.dart';
import 'package:ditonton/domain/entities/tvseries_episode.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TVSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TVSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get On The Air TVSeries', () {
    final TVSeriesList = TVSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/on_the_air.json')))
        .tvseriesList;

    test('should return list of TVSeries Model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/on_the_air.json'), 200));
          // act
          final result = await dataSource.getOnTheAir();
          // assert
          expect(result, equals(TVSeriesList));
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getOnTheAir();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('Episode TVSeries',(){
    final TVSeriesEpisodeList = TVSeriesEpisodeResponse.fromJson(json.decode(readJson('dummy_data/tvseries_episode.json'))).tvseriesEpisodeList;

    test('should return list of movies when response is success (200)',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/60735/season/1?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tvseries_episode.json'), 200));
          // act
          final result = await dataSource.getEpisodeTVSeries(60735, 1);
          // assert
          expect(result, TVSeriesEpisodeList);
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/60735/season/1?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getEpisodeTVSeries(60735, 1);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });

  });

  group('get Popular TVSeries', () {
    final TVSeriesList =
        TVSeriesResponse.fromJson(json.decode(readJson('dummy_data/tvseries_popular.json')))
            .tvseriesList;

    test('should return list of movies when response is success (200)',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tvseries_popular.json'), 200));
          // act
          final result = await dataSource.getPopularTVSeries();
          // assert
          expect(result, TVSeriesList);
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getPopularTVSeries();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Top Rated TV Series', () {
    final TVSeriesList = TVSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/tvseries_top_rated.json')))
        .tvseriesList;

    test('should return list of movies when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/tvseries_top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTVSeries();
      // assert
      expect(result, TVSeriesList);
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTopRatedTVSeries();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get tvseries detail', () {
    final tId = 1;
    final tTVSeriesDetail = TVSeriesDetailModel.fromJson(
        json.decode(readJson('dummy_data/tvseries_detail.json')));

    test('should return tv series detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/tvseries_detail.json'), 200));
      // act
      final result = await dataSource.getTVSeriesDetail(tId);
      // assert
      expect(result, equals(tTVSeriesDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTVSeriesDetail(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get movie recommendations', () {
    final tTVSeriesList = TVSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/tvseries_recomendations.json')))
        .tvseriesList;
    final tId = 1;

    test('should return list of TVSeries Model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvseries_recomendations.json'), 200));
          // act
          final result = await dataSource.getTVSeriesRecommendations(tId);
          // assert
          expect(result, equals(tTVSeriesList));
        });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTVSeriesRecommendations(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('search tvseries', () {
    final tSearchResult = TVSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/tvseries_search_drstone.json')))
        .tvseriesList;
    final tQuery = 'Dr Stone';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockHttpClient
          .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
          readJson('dummy_data/tvseries_search_drstone.json'), 200));
      // act
      final result = await dataSource.searchTVSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.searchTVSeries(tQuery);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });
}
