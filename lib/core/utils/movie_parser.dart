import 'dart:convert';

import '../../models/movie_response.dart';

// PARSE MOVIES
MovieResponse parseMovies(
    String responseBody,
    ) {

  final jsonData =
  jsonDecode(responseBody);

  return MovieResponse.fromJson(
    jsonData,
  );
}