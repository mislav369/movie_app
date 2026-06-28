import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/di.dart';
import 'package:movie_app/presentation/core/app_router.dart';
import 'package:movie_app/presentation/movies/widget/movie_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(libraryNotifierProvider).favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: movies.isEmpty
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.favorite_border,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              'No favorite movies yet.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: movies.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 12);
        },
        itemBuilder: (_, index) {
          final movie = movies[index];

          return MovieCard(
            movie: movie,
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRouter.details,
                arguments: movie,
              );
            },
          );
        },
      ),
    );
  }
}