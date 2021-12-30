import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TopRatedMovieBloc>().add(
        OnTopRatedMovieTask()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<TopRatedMovieBloc,TopRatedMovieState>(
          builder: (context, state) {
            if (state is TopRatedMovieIsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedMovieLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.topRatedMovies[index];
                  return MovieCard(movie);
                },
                itemCount: state.topRatedMovies.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text('Error'),
              );
            }
          },
          listener: (context, state) {
            if (state is TopRatedMovieError) {
              context.dialog(state.errMessage,state.tryAgain);
            }
          },
        ),
      ),
    );
  }
}
