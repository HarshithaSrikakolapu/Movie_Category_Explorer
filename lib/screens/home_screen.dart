import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/movie_viewmodel.dart';
import 'movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final vm = context.watch<MovieViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movie Explorer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isTablet ? 32 : screenWidth * 0.025,
          ),
        ),
      ),
      body: Column(
        children: [
          // SEARCH BAR
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              onChanged: vm.onSearchChanged,
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.white70),
                hintText: 'Search horror, marvel, comedy...',
                prefixIcon: const Icon(Icons.search, color: Colors.red),
              ),
            ),
          ),
          Expanded(
            child: Builder(
              builder: (_) {
                // LOADING
                if (vm.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                // ERROR
                if (vm.error != null) {
                  return Center(child: Text(vm.error!));
                }

                // EMPTY
                if (vm.movies.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Search movie category',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Try horror, marvel, comedy...',
                          style: TextStyle(color: Color.fromARGB(255, 245, 242, 242)),
                        ),
                      ],
                    ),
                  );
                }

                // SUCCESS
                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (scrollInfo.metrics.pixels >=
                        scrollInfo.metrics.maxScrollExtent - 200) {
                      vm.loadMore();
                    }
                    return false;
                  },
                  child: ListView.builder(
                    itemCount: vm.movies.length + 1,
                    itemBuilder: (context, index) {
                      // PAGINATION LOADER
                      if (index == vm.movies.length) {
                        return vm.isPaginationLoading
                            ? const Padding(
                                padding: EdgeInsets.all(20),
                                child: Center(child: CircularProgressIndicator()),
                              )
                            : const SizedBox();
                      }

                      final movie = vm.movies[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MovieDetailsScreen(
                                imdbId: movie.imdbId,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: const Color(0xFF1E1E1E),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                // POSTER
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    movie.poster,
                                    width: isTablet ? 140 : screenWidth * 0.18,
                                    height: isTablet ? 200 : screenWidth * 0.28,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) {
                                      return Container(
                                        width: 90,
                                        height: 130,
                                        color: Colors.grey,
                                        child: const Icon(
                                          Icons.movie,
                                          size: 40,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              isTablet ? 24 : screenWidth * 0.018,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        movie.year,
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize:
                                              isTablet ? 18 : screenWidth * 0.012,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      // MOVIE TYPE + FAVORITE
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // MOVIE TYPE
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              movie.type.toUpperCase(),
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          // FAVORITE BUTTON
                                          IconButton(
                                            onPressed: () {
                                              vm.toggleFavorite(movie.imdbId);
                                            },
                                            icon: Icon(
                                              vm.isFavorite(movie.imdbId)
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.red,
                                              size: isTablet
                                                  ? 36
                                                  : screenWidth * 0.03,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

