import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tvseries_episode_notifier.dart';
import 'package:ditonton/presentation/widgets/tvseries_episodes_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Future.microtask(() =>
        Provider.of<EpisodeTVSeriesNotifier>(context, listen: false)
            .fetchEpisodeTVSeries(widget.id,widget.season));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Episode TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<EpisodeTVSeriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvserie = data.tvseries[index];
                  return TVSeriesEpisodeCard(tvserie);
                },
                itemCount: data.tvseries.length ,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
