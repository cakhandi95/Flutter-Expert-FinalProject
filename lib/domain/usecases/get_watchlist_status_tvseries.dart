import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetWatchListStatusTVSeries {
  final TVSeriesRepository repository;

  GetWatchListStatusTVSeries(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTVSeries(id);
  }
}
