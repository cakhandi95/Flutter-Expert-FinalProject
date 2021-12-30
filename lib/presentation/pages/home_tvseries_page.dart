import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_tvseries_page.dart';
import 'package:ditonton/presentation/pages/search_tvseries.dart';
import 'package:ditonton/presentation/pages/top_rated_tvseries_page.dart';
import 'package:ditonton/presentation/pages/tvseries_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tvseriespage.dart';
import 'package:ditonton/presentation/bloc/on_the_air_tvseries/on_the_air_tvseries_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tvseries/popular_tvseries_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tvseries/top_rated_tvseries_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tvseries';
  @override
  _TVSeriesPageState createState() => _TVSeriesPageState();
}

class _TVSeriesPageState extends State<TVSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnTheAirTvSeriesBloc>().add(
        OnTheAirTvSeriesTask()
    );

    context.read<PopularTvSeriesBloc>().add (
        OnPopulerTvSeriesTask()
    );

    context.read<TopRatedTvSeriesBloc>().add(
        TopRatedTvSeriesTask()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton V1'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.monitor),
              title: Text('TV Series'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist - TV Series'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTVSeriesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist - Movie'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton - TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPageTVSeries.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'On The Air',
                style: kHeading6,
              ),
              BlocConsumer<OnTheAirTvSeriesBloc,OnTheAirTvSeriesState>(
                  builder: (context,state) {
                    if(state is OnTheAirTvSeriesIsLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is OnTheAirTvSeriesLoaded) {
                      return TVSeriesList(state.onTheAirTVSeries);
                    } else {
                      return Text('Failed');
                    }
                  },
                  listener: (context, state) {
                    if (state is OnTheAirTvSeriesError) {
                      context.dialog(state.errMessage, state.tryAgain);
                    }
                  }
                  ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTVSeriesPage.ROUTE_NAME),
              ),
              BlocConsumer<PopularTvSeriesBloc,PopulerTvSeriesState>(
                  builder: (context,state) {
                    if(state is OnTheAirTvSeriesIsLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is PopularTvSeriesLoaded) {
                      return TVSeriesList(state.popularTVSeries);
                    } else {
                      return Text('Failed');
                    }
                  },
                  listener: (context, state) {
                    if (state is PopularTvSeriesError) {
                      context.dialog(state.errMessage, state.tryAgain);
                    }
                  }
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTVSeriesPage.ROUTE_NAME),
              ),
              BlocConsumer<TopRatedTvSeriesBloc,TopRatedTvSeriesState>(
                  builder: (context, state) {
                    if(state is TopRatedTvSeriesIsLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TopRatedTvSeriesLoaded) {
                      return TVSeriesList(state.topRatedTvSeries);
                    } else {
                      return Text('Failed');
                    }
                  },
                  listener: (context, state) {
                    if (state is TopRatedTvSeriesError) {
                      context.dialog(state.errMessage, state.tryAgain);
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVSeriesList extends StatelessWidget {
  final List<TVSeries> tvseries;

  TVSeriesList(this.tvseries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvserie = tvseries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVSeriesDetailPage.ROUTE_NAME,
                  arguments: tvserie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvserie.poster_path}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvseries.length,
      ),
    );
  }
}
