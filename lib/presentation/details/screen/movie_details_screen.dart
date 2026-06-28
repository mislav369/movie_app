import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/di.dart';
import 'package:movie_app/domain/model/collection_type.dart';
import 'package:movie_app/domain/model/movie.dart';
import 'package:movie_app/presentation/details/provider/movie_details_provider.dart';
import 'package:movie_app/presentation/core/widget/rating_badge.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsScreen extends ConsumerWidget {
  final Movie movie;

  const MovieDetailsScreen({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsAsync = ref.watch(movieDetailsProvider(movie.id));
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    ref.watch(libraryNotifierProvider);
    final libraryNotifier = ref.read(libraryNotifierProvider.notifier);

    final isFavorite = libraryNotifier.isIn(
      movie.id,
      CollectionType.favorite,
    );

    final isWatchlist = libraryNotifier.isIn(
      movie.id,
      CollectionType.watchlist,
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'poster_${movie.id}',
                  child: (movie.posterUrl != null && movie.posterUrl!.isNotEmpty)
                      ? CachedNetworkImage(
                    imageUrl: movie.posterUrl!,
                    width: double.infinity,
                    height: 360,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Container(
                      height: 360,
                      color: Colors.grey.shade400,
                      child: const Icon(Icons.broken_image),
                    ),
                  )
                      : Container(
                    width: double.infinity,
                    height: 360,
                    color: Colors.grey.shade400,
                    child: const Icon(Icons.movie, size: 64),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 8,
                  left: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  detailsAsync.when(
                    loading: () {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    error: (error, stackTrace) {
                      return Text(
                        movie.plot ?? 'Could not load full details.',
                      );
                    },
                    data: (fullMovie) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (fullMovie.year != null) ...[
                                Icon(Icons.calendar_today_outlined,
                                    size: 16, color: colors.onSurfaceVariant),
                                const SizedBox(width: 4),
                                Text(
                                  '${fullMovie.year}',
                                  style: textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 16),
                              ],
                              RatingBadge(rating: fullMovie.rating),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Overview',
                            style: textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            fullMovie.plot ?? 'No description available.',
                            style: textTheme.bodyMedium?.copyWith(
                              height: 1.5,
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {
                            libraryNotifier.toggle(
                              movie,
                              CollectionType.favorite,
                            );
                          },
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          label: Text(
                            isFavorite ? 'In favorites' : 'Favorite',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            libraryNotifier.toggle(
                              movie,
                              CollectionType.watchlist,
                            );
                          },
                          icon: Icon(
                            isWatchlist
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                          ),
                          label: Text(
                            isWatchlist ? 'In watchlist' : 'Plan to watch',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.tonalIcon(
                      onPressed: () => watchTrailer(context, movie.title),
                      icon: const Icon(Icons.play_circle_outline),
                      label: const Text('Watch trailer'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> watchTrailer(BuildContext context, String title) async {
  final query = Uri.encodeComponent('$title official trailer');

  final Uri uri;
  if (Platform.isIOS) {
    // iOS: prvo probaj nativnu YouTube app, pa fallback na web
    final appUri = Uri.parse('youtube://results?search_query=$query');
    final webUri =
    Uri.parse('https://www.youtube.com/results?search_query=$query');
    uri = await canLaunchUrl(appUri) ? appUri : webUri;
  } else {
    // Android: sustav sam otvori YouTube app ili preglednik
    uri = Uri.parse('https://www.youtube.com/results?search_query=$query');
  }

  final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!ok && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not open trailer.')),
    );
  }
}