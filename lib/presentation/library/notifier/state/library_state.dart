import 'package:movie_app/domain/model/movie.dart';

class LibraryState {
  final List<Movie> favorites;
  final List<Movie> watchlist;

  const LibraryState({
    this.favorites = const [],
    this.watchlist = const [],
  });
}