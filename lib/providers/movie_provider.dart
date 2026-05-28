import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/movie_repository.dart';

import '../services/movie_service.dart';

import '../viewmodels/movie_viewmodel.dart';

import 'package:dio/dio.dart';

final dioProvider = Provider<Dio>((ref){

  final dio = Dio();

  dio.options.queryParameters = {

    'apikey': 'ac7bb03c',
  };

  return dio;
});

final movieServiceProvider =
Provider<MovieService>((ref){

  final dio =
  ref.watch(dioProvider);

  return MovieService(

  dio,

  baseUrl:
  'https://www.omdbapi.com/',
);
});

final movieRepositoryProvider =
Provider<MovieRepository>((ref){

  final service =
  ref.watch(movieServiceProvider);

  return MovieRepository(service);
});

final movieViewModelProvider =

ChangeNotifierProvider<MovieViewModel>((ref){

  final repository =
  ref.watch(movieRepositoryProvider);

  return MovieViewModel(repository);
});