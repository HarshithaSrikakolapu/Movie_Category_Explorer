import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // HIVE INIT
  await Hive.initFlutter();

  // OPEN BOX
  await Hive.openBox('favorites');

  runApp(

  const ProviderScope(

    child: MyApp(),
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