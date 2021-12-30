import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/popular_tvseries/popular_tvseries_bloc.dart';
import 'package:ditonton/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tvseries';

  @override
  _PopularTVSeriesPageState createState() => _PopularTVSeriesPageState();
}

class _PopularTVSeriesPageState extends State<PopularTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularTvSeriesBloc>().add(
        OnPopulerTvSeriesTask()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<PopularTvSeriesBloc,PopulerTvSeriesState>(
          builder: (context, state) {
            if (state is PopularTvSeriesIsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvSeriesLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvseries = state.popularTVSeries[index];
                  return TVSeriesCard(tvseries);
                },
                itemCount: state.popularTVSeries.length ,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text('error'),
              );
            }
          }, listener: (context, state) {
          if(state is PopularTvSeriesError) {
            context.dialog(state.errMessage,state.tryAgain);
          }
        },
        ),
      ),
    );
  }
}
