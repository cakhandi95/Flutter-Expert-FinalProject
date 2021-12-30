import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/widgets/tvseries_card_list.dart';
import 'package:ditonton/presentation/bloc/top_rated_tvseries/top_rated_tvseries_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TopRatedTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tvseries';

  @override
  _TopRatedTVSeriesPageState createState() => _TopRatedTVSeriesPageState();
}

class _TopRatedTVSeriesPageState extends State<TopRatedTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TopRatedTvSeriesBloc>().add(TopRatedTvSeriesTask());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<TopRatedTvSeriesBloc,TopRatedTvSeriesState>(
          builder: (context, state) {
            if (state is TopRatedTvSeriesIsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvSeriesLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.topRatedTvSeries[index];
                  return TVSeriesCard(tvSeries);
                },
                itemCount: state.topRatedTvSeries.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text('Error_'),
              );
            }
          },
          listener: (context,state) {
            if(state is TopRatedTvSeriesError) {
              context.dialog(state.errMessage, state.tryAgain);
            }
          },
        ),
      ),
    );
  }
}
