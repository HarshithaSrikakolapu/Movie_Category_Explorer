import 'package:flutter/material.dart';
import '../providers/movie_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie_details_model.dart';
class MovieDetailsScreen
extends ConsumerStatefulWidget  {
  final String imdbId;
  const MovieDetailsScreen({
    super.key,
    required this.imdbId,
  });
  @override
ConsumerState<MovieDetailsScreen> createState() =>
    _MovieDetailsScreenState();
}
class _MovieDetailsScreenState
    extends ConsumerState<MovieDetailsScreen> {
  MovieDetailsModel? movie;
  bool isLoading = true;
  String? error;
  @override
  void initState() {
    super.initState();
    fetchMovieDetails();
  }
  Future<void> fetchMovieDetails() async {
    try {
      final repository =
          ref.read(movieViewModelProvider).repository;
      movie =
      await repository.getMovieDetails(
        widget.imdbId,
      );
    } catch (e) {
      error = e.toString();
    } finally {

      setState(() {

        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width =
    MediaQuery.of(context)
        .size
        .width;

final isTablet =
    width > 600;
    // LOADING
    if (isLoading) {

      return const Scaffold(

        body: Center(
          child:
          CircularProgressIndicator(),
        ),
      );
    }

    // ERROR
    if (error != null) {

      return Scaffold(

        appBar: AppBar(),

        body: Center(
          child: Text(error!),
        ),
      );
    }

    final m = movie!;

    return Scaffold(

      appBar: AppBar(
        title: Text(m.title),
      ),

      body: SingleChildScrollView(

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            // POSTER
            Image.network(

              m.poster,

              width: double.infinity,

              height:

isTablet

? 600

: width * 0.8,

              fit: BoxFit.cover,

              errorBuilder:
                  (_, __, ___) {

                return Container(

                  height: 450,

                  color: Colors.grey,

                  child: const Center(

                    child: Icon(
                      Icons.movie,
                      size: 100,
                    ),
                  ),
                );
              },
            ),

            Padding(

              padding: EdgeInsets.all(
  isTablet
      ? 30
      : width * 0.04,
),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(

                    m.title,

                    style: TextStyle(
  fontSize:
      isTablet
          ? 36
          : width * 0.06,
  fontWeight: FontWeight.bold,
),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Year: ${m.year}',
                    style: TextStyle(
  fontSize:
      isTablet
          ? 22
          : width * 0.035,
),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Genre: ${m.genre}',
                    style: TextStyle(
  fontSize:
      isTablet
          ? 22
          : width * 0.035,
),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Director: ${m.director}',
                    style: TextStyle(
  fontSize:
      isTablet
          ? 22
          : width * 0.035,
),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Actors: ${m.actors}',
                    style: TextStyle(
  fontSize:
      isTablet
          ? 22
          : width * 0.035,
),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'IMDb Rating: ${m.imdbRating}',
                    style: TextStyle(
  fontSize:
      isTablet
          ? 22
          : width * 0.035,
),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Runtime: ${m.runtime}',
                    
                    style: TextStyle(
  fontSize:
      isTablet
          ? 22
          : width * 0.035,
),
                  ),

                  const SizedBox(height: 20),

                  Text(
  'Plot',
  style: TextStyle(
    fontSize:
        isTablet
            ? 30
            : width * 0.05,
    fontWeight: FontWeight.bold,
  ),
),

                  const SizedBox(height: 10),

                  Text(

                    m.plot,

                    style: TextStyle(
  fontSize:
      isTablet
          ? 22
          : width * 0.035,
),
                    ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}