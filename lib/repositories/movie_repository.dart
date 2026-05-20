import '../models/movie_details_model.dart';
import '../models/movie_response.dart';

import '../services/base_movie_service.dart';
class MovieRepository {

  final BaseMovieService service;

  MovieRepository(this.service);
  Future<dynamic>
searchMoviesRaw(
    String category,
    int page,
    ){

  return service.searchMoviesRaw(
    category,
    page,
  );
}
  // SEARCH MOVIES
  Future<MovieResponse> searchMovies(
      String category,
      int page,
      ) {

    return service.searchMovies(
      category,
      page,
    );
  }

  // GET FULL DETAILS
  Future<MovieDetailsModel> getMovieDetails(
      String imdbId,
      ) {

    return service.getMovieDetails(
      imdbId,
    );
  }
}