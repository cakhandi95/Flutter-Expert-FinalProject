import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries_episode.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetEpisodeTVSeries {
  final TVSeriesRepository repository;

  GetEpisodeTVSeries(this.repository);

  Future<Either<Failure, List<TVSeriesEpisode>>> execute(int id, int season) {
    return repository.getEpisode(id,season);
  }
}
