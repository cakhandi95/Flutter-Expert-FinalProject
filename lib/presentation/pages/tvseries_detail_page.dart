import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/presentation/bloc/tvseries_detail/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_status/watchlist_status_bloc.dart';
import 'package:ditonton/presentation/pages/tvseries_episode_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TVSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tvseries';

  final int id;
  TVSeriesDetailPage({required this.id});

  @override
  _TVSeriesDetailPageState createState() => _TVSeriesDetailPageState();
}

class _TVSeriesDetailPageState extends State<TVSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvSeriesDetailBloc>().add(
        OnTvSeriesRecommendationResult(widget.id)
    );
    context.read<TvSeriesDetailBloc>().add(
        IdTvSeriesDetailResult(widget.id)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TvSeriesDetailBloc,TvSeriesDetailState>(
        builder: (context, state) {
          if (state is TvSeriesDetailIsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeriesDetailLoaded) {
            final tvseries = state.tvSeriesDetail;
            return SafeArea(
              child: DetailContent(
                tvseries,
                state.recommendations,
                state.isCheckedLoaded,
              ),
            );
          } else {
            return Text('Error');
          }
        },listener: (context, state) {

      },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TVSeriesDetail tvseries;
  final List<TVSeries> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.tvseries, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvseries.poster_path}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvseries.name,
                              style: kHeading5,
                            ),

                            BlocConsumer(
                                builder: (context, state) {
                                  return ElevatedButton(
                                    onPressed: () async {
                                      if (!isAddedWatchlist) {
                                        context.read<WatchListStatusBloc>().add(
                                            OnListTvSeriesAdded(tvseries)
                                        );
                                      } else {
                                        context.read<WatchListStatusBloc>().add(
                                            OnListTvSeriesRemoved(tvseries)
                                        );
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        isAddedWatchlist
                                            ? Icon(Icons.check)
                                            : Icon(Icons.add),
                                        Text('Watchlist'),
                                      ],
                                    ),
                                  );
                                },
                                listener: (context, state) {
                                  String message = "Sedang Memuat";
                                  if (state is WatchListStatusIsLoading) {
                                    print('Added Watchlist :$message');
                                  } else if (state is WatchlistStatusSuccess) {
                                    message = state.message;
                                    print('Added Watchlist :$message');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(message)));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text('Error_TV_Series'),
                                          );
                                        });
                                  }
                                }
                            ),
                            Text(
                              _showGenres(tvseries.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvseries.vote_average / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvseries.vote_average}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvseries.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocConsumer<TvSeriesDetailBloc,TvSeriesDetailState>(
                              builder: (context, state) {
                                if (state is TvSeriesDetailIsLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvSeriesDetailError) {
                                  return Text(state.errMessage);
                                } else if (state is TvSeriesDetailLoaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvseries = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TVSeriesDetailPage.ROUTE_NAME,
                                                arguments: tvseries.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                'https://image.tmdb.org/t/p/w500${tvseries.poster_path}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                      child:
                                                      CircularProgressIndicator(),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                    Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }, listener: (context,state) {

                            },),

                            SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            BlocConsumer<TvSeriesDetailBloc,TvSeriesDetailState>(
                              builder: (context, state){
                                if (state is TvSeriesDetailIsLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvSeriesDetailError) {
                                  return Text(state.errMessage);
                                } else if (state is TvSeriesDetailLoaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final season = tvseries.seasons[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              print("Mancep");
                                              String arg = tvseries.id.toString()+"#"+(index+1).toString();
                                              print(arg);
                                              Navigator.pushReplacementNamed(
                                                context,
                                                EpisodeSeriesPage.ROUTE_NAME,
                                                arguments: arg,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: season.poster_path != ""?CachedNetworkImage(
                                                imageUrl:
                                                'https://image.tmdb.org/t/p/w500${season.poster_path}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                      child:
                                                      CircularProgressIndicator(),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                    Icon(Icons.error),
                                              ):Image.asset('assets/not-found.png') ,
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: tvseries.seasons.length,
                                    ),
                                  );
                                }else {
                                  return Container();
                                }
                              },listener: (context, state) {
                              if(state is TvSeriesDetailError) {
                                context.dialog(state.errMessage,state.tryAgain);
                              }
                            },),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

}
