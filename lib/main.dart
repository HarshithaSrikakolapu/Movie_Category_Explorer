import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';
void main() {

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
  theme: ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor:
    const Color(0xFF121212),
    primaryColor:
    Colors.red,
    appBarTheme: const AppBarTheme(
      backgroundColor:
      Color(0xFF1E1E1E),
      elevation: 0,
      centerTitle: true,
    ),
    inputDecorationTheme:
    InputDecorationTheme(
      filled: true,
      fillColor:
      const Color(0xFF1E1E1E),
      border: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(14),
        borderSide:
        const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
    ),
  ),
  home: const HomeScreen(),
);
  }
}