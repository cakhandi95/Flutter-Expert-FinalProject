import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularMovieBloc>().add(
        OnPopularMovieTask()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<PopularMovieBloc,PopularMovieState>(
          builder: (context, state) {
            if (state is PopularMovieIsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMovieLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.popularMovies[index];
                  return MovieCard(movie);
                },
                itemCount: state.popularMovies.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text('Error'),
              );
            }
          },
          listener: (context, state) {
            if(state is PopularMovieError) {
              context.dialog(state.errMessage, state.tryAgain);
            }
          },
        ),
      ),
    );
  }
}
