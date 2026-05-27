import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../core/utils/movie_parser.dart';
import '../models/movie_model.dart';
import '../repositories/movie_repository.dart';
import '../services/local_storage_service.dart';
class MovieViewModel extends ChangeNotifier {

  final MovieRepository repository;
  final LocalStorageService localStorageService =
    LocalStorageService();
  MovieViewModel(this.repository){
    

  favoriteMovieIds =
      localStorageService.getFavorites();

    scrollController.addListener(() {

      if(scrollController.position.pixels >=
          scrollController.position.maxScrollExtent){

        loadMore();
      }
    });
  }

  // MOVIES
  List<MovieModel> movies = [];

  // FAVORITES
  List<String> favoriteMovieIds = [];

  // LOADING
  bool isLoading = false;

  bool isPaginationLoading = false;

  // ERROR
  String? error;

  // PAGINATION
  int page = 1;

  bool hasMore = true;

  // CURRENT CATEGORY
  String currentCategory = '';

  // SEARCH DEBOUNCE
  Timer? debounce;

  // SCROLL CONTROLLER
  final ScrollController scrollController =
  ScrollController();

  // SEARCH MOVIES
  Future<void> searchMovies(
      String category,
      ) async {

    // EMPTY SEARCH
    if(category.trim().isEmpty){

      movies.clear();

      notifyListeners();

      return;
    }

    try {

      isLoading = true;

      error = null;

      page = 1;

      hasMore = true;

      currentCategory = category;

      movies.clear();

      notifyListeners();

      // FETCH RAW JSON
      final rawJson =

      await repository.searchMoviesRaw(

        category,

        page,
      );

      // PARSE IN ISOLATE
      final response =

      await compute(

        parseMovies,

        jsonEncode(rawJson),
      );

      movies = response.movies ?? [];

    } catch (e) {

      error = e.toString();

    } finally {

      isLoading = false;

      notifyListeners();
    }
  }

  // LOAD MORE
  Future<void> loadMore() async {

    if(!hasMore ||
        currentCategory.isEmpty){

      return;
    }

    try {

      isPaginationLoading = true;

      notifyListeners();

      page++;

      // FETCH RAW JSON
      final rawJson =

      await repository.searchMoviesRaw(

        currentCategory,

        page,
      );

      // PARSE IN ISOLATE
      final response =

      await compute(

        parseMovies,

        jsonEncode(rawJson),
      );

      final newMovies =
          response.movies ?? [];

      // NO MORE DATA
      if(newMovies.isEmpty){

        hasMore = false;

      } else {

        movies.addAll(newMovies);
      }

    } catch (e) {

      error = e.toString();

    } finally {

      isPaginationLoading = false;

      notifyListeners();
    }
  }

  // SEARCH DEBOUNCE
  void onSearchChanged(String value){

    if(debounce?.isActive ?? false){

      debounce!.cancel();
    }

    debounce = Timer(

      const Duration(milliseconds: 500),

          () {

        searchMovies(value);
      },
    );
  }

  // FAVORITE TOGGLE
  void toggleFavorite(String imdbId) {

  if (favoriteMovieIds.contains(imdbId)) {

    favoriteMovieIds.remove(imdbId);

  } else {

    favoriteMovieIds.add(imdbId);
  }

  localStorageService.saveFavorites(
    favoriteMovieIds,
  );

  notifyListeners();
}
  // CHECK FAVORITE
  bool isFavorite(String imdbId){

    return favoriteMovieIds.contains(imdbId);
  }

  // REFRESH
  Future<void> refreshMovies() async {

    page = 1;

    hasMore = true;

    movies.clear();

    await searchMovies(currentCategory);
  }

  // DISPOSE
  @override
  void dispose() {

    debounce?.cancel();

    scrollController.dispose();

    super.dispose();
  }
}