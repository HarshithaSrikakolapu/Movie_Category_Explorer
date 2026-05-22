import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';


import '../models/movie_details_model.dart';
import '../models/movie_response.dart';
import 'base_movie_service.dart';

part 'movie_service.g.dart';

@RestApi()
abstract class MovieService implements BaseMovieService {
  factory MovieService(
    Dio dio, {
    String? baseUrl,
  }) = _MovieService;

  // SEARCH MOVIES
  @override
  @GET('/')
  Future<MovieResponse> searchMovies(
    @Query('s') String category,
    @Query('page') int page,
  );

  // RAW JSON SEARCH
  @override
  @GET('/')
  Future<Map<String, dynamic>> searchMoviesRaw(
    @Query('s') String category,
    @Query('page') int page,
  );




  // GET FULL MOVIE DETAILS
  @override
  @GET('/')
  Future<MovieDetailsModel> getMovieDetails(
    @Query('i') String imdbId,
  );

}
