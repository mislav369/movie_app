import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/di.dart';
import 'package:movie_app/presentation/core/app_router.dart';
import 'package:movie_app/presentation/movies/notifier/state/movie_list_state.dart';
import 'package:movie_app/presentation/movies/widget/movie_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(movieListNotifierProvider);
    final notifier = ref.read(movieListNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: notifier.search,
              decoration: InputDecoration(
                hintText: 'Search movies',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withValues(alpha: 0.4),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: switch (state) {
                LoadingState() => const Center(
                  key: ValueKey('loading'),
                  child: CircularProgressIndicator(),
                ),
                EmptyState() => Center(
                  key: const ValueKey('empty'),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.movie_filter_outlined,
                        size: 48,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No movies found.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                ErrorState(message: final message) => Center(
                  key: const ValueKey('error'),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.wifi_off_outlined,
                          size: 48,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                SuccessState(movies: final movies) => ListView.separated(
                  key: const ValueKey('list'),
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
              },
            ),
          ),
        ],
      ),
    );
  }
}