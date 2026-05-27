import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'core/network/dio_client.dart';
import 'repositories/movie_repository.dart';
import 'screens/home_screen.dart';
import 'services/movie_service.dart';
import 'viewmodels/movie_viewmodel.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // HIVE INIT
  await Hive.initFlutter();

  // OPEN BOX
  await Hive.openBox('favorites');

  final dioClient = DioClient();

  final service =
      MovieService(dioClient.dio);

  runApp(

    MultiProvider(

      providers: [

        ChangeNotifierProvider(

          create: (_) => MovieViewModel(
            MovieRepository(service),
          ),
        ),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      theme: ThemeData.dark(),

      home: const HomeScreen(),
    );
  }
}