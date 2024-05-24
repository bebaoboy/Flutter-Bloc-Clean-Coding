import 'package:animations/animations.dart';
import 'package:bloc_clean_coding/bloc/movies_bloc/movies_bloc.dart';
import 'package:bloc_clean_coding/configs/routes/routes_name.dart';
import 'package:bloc_clean_coding/data/response/response.dart';
import 'package:bloc_clean_coding/data/response/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_clean_coding/utils/language.dart';
import 'package:go_router/go_router.dart';

import '../../configs/components/network_image_widget.dart';
import '../../main.dart';
import 'widget/widgets.dart';

/// A widget representing the screen displaying a list of movies.
class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _HomeViewState();
}

/// The state of the [MoviesScreen] widget.
class _HomeViewState extends State<MoviesScreen> {
  late MoviesBloc moviesBloc;

  @override
  void initState() {
    super.initState();
    moviesBloc = MoviesBloc(moviesApiRepository: getIt());
    // Dispatches the [PostFetched] event to trigger fetching movies data
  }

  @override
  void dispose() {
    moviesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(Lang.g(context).popularShows),
        actions: const [
          LogoutButtonWidget(), // Widget for logout button
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: BlocProvider(
        create: (_) => moviesBloc..add(MoviesFetch()),
        child: BlocBuilder<MoviesBloc, MoviesState>(
          buildWhen: (previous, current) =>
              previous.moviesList != current.moviesList,
          builder: (BuildContext context, state) {
            switch (state.moviesList.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.error:
                return const MoviesErrorWidget(); // Widget for displaying error state
              case Status.completed:
                if (state.moviesList.data == null) {
                  // Widget for displaying no data found message
                  return Text(Lang.g(context).noDataFound);
                }
                final movieList = state.moviesList.data!;

                return ListView.builder(
                    itemCount: movieList.tvShow.length,
                    itemBuilder: (context, index) {
                      final tvShow = movieList.tvShow[index];
                      final tvCardWidget = Card(
                        child: ListTile(
                          leading: NetworkImageWidget(
                            borderRadius: 5,
                            imageUrl: tvShow.imageThumbnailPath.toString(),
                          ), // Widget for displaying network image
                          title: Text(
                              tvShow.name.toString()), // Title of the movie
                          subtitle: Text(tvShow.network
                              .toString()), // Network of the movie
                          trailing: Text(
                              tvShow.status.toString()), // Status of the movie
                        ),
                      );
                      return tvShow.status == "Running"
                          ? OpenContainer(
                              closedColor: Colors.transparent,
                              openBuilder: (context, action) => Scaffold(
                                appBar: AppBar(
                                  title: Text(tvShow.name.toString()),
                                ),
                              ),
                              closedBuilder: (context, action) => tvCardWidget,
                            )
                          : InkWell(
                              onTap: () {
                                context.push(RoutesName.login);
                              },
                              child: tvCardWidget,
                            );
                    });
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
