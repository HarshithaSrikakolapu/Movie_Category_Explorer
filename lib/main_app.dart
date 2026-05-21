import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/flavor_config.dart';
import 'repositories/movie_repository.dart';
import 'screens/home_screen.dart';
import 'services/movie_service.dart';
import 'viewmodels/movie_viewmodel.dart';

class MainApp extends StatelessWidget {

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    final dio = Dio();

    dio.options.queryParameters = {

      'apikey': 'ac7bb03c',
    };

    final service =
    MovieService(

      dio,

      baseUrl:
      FlavorConfig
          .config
          .apiBaseUrl,
    );

    return ChangeNotifierProvider(

      create: (_) =>

          MovieViewModel(

            MovieRepository(service),
          ),

      child: MaterialApp(

        debugShowCheckedModeBanner:

        FlavorConfig
            .config
            .isDev,

        title:
        FlavorConfig
            .config
            .appName,

        theme: ThemeData(

          scaffoldBackgroundColor:
          const Color.fromARGB(255, 27, 26, 26),

          appBarTheme: AppBarTheme(

            backgroundColor:

            FlavorConfig
                .config
                .isDev

                ? const Color.fromARGB(255, 244, 51, 12)

                : const Color.fromARGB(255, 18, 17, 17),
          ),
        ),

        home:
        const HomeScreen(),
      ),
    );
  }
}