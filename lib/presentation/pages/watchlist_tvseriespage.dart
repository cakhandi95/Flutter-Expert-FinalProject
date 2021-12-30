import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/watchlist_tvseries/watchlist_tvseries_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tvseries/watchlist_tvseries_event.dart';
import 'package:ditonton/presentation/bloc/watchlist_tvseries/watchlist_tvseries_state.dart';
import 'package:ditonton/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tvseries';

  @override
  _WatchlistTVSeriesPageState createState() => _WatchlistTVSeriesPageState();
}

class _WatchlistTVSeriesPageState extends State<WatchlistTVSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistTvSeriesBloc>().add(
        OnWatchListTvSeriesRequest()
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistTvSeriesBloc>().add(
        OnWatchListTvSeriesRequest()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist - TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<WatchlistTvSeriesBloc,WatchListTvSeriesState>(
          builder: (context, state) {
            if (state is WatchListTvSeriesIsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchListTvSeriesLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.watchlistTVSeries[index];
                  return TVSeriesCard(tvSeries);
                },
                itemCount: state.watchlistTVSeries.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text('Error Watchlist TV Series'),
              );
            }
          },
          listener: (context, state) {
            if(state is WatchListTvSeriesError){
              context.dialog(state.errMessage, state.tryAgain);
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
