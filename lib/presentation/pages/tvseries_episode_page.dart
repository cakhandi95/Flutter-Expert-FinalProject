import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/episode_tvseries/episode_tvseries_bloc.dart';
import 'package:ditonton/presentation/bloc/episode_tvseries/episode_tvseries_event.dart';
import 'package:ditonton/presentation/bloc/episode_tvseries/episode_tvseries_state.dart';
import 'package:ditonton/presentation/widgets/tvseries_episodes_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EpisodeSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/episode-tvseries';

  final int season,id;
  EpisodeSeriesPage({required this.season, required this.id});


  @override
  _EpisodeSeriesPageState createState() => _EpisodeSeriesPageState();
}

class _EpisodeSeriesPageState extends State<EpisodeSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<EpisodeTvSeriesBloc>().add(
        EpisodeTvSeriesRequestData(id: widget.id, season: widget.season)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Episode TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<EpisodeTvSeriesBloc,EpisodeTvSeriesState>(
          builder: (context, state) {
            if (state is EpisodeTvSeriesIsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is EpisodeTvSeriesLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.tvSeriesEpisode[index];
                  return TVSeriesEpisodeCard(tvSeries);
                },
                itemCount: state.tvSeriesEpisode.length,
              );
            } else if (state is EpisodeTvSeriesError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.errMessage),
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text('Error'),
              );
            }
          },listener: (context, state) {
            if(state is EpisodeTvSeriesError) {
              context.dialog(state.errMessage,state.tryAgain);
            }
        },),
      ),
    );
  }
}
