import '../models/movie_details_model.dart';
import '../models/movie_response.dart';

abstract class BaseMovieService {

  // SEARCH MOVIES
  Future<MovieResponse> searchMovies(
    String category,
    int page,
  );

  // RAW JSON SEARCH
  Future<Map<String, dynamic>>
  searchMoviesRaw(
    String category,
    int page,
  );


  // MOVIE DETAILS
  Future<MovieDetailsModel>
  getMovieDetails(
    String imdbId,
  );
}