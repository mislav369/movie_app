import 'package:movie_app/domain/model/collection_type.dart';
import 'package:movie_app/domain/model/movie.dart';

abstract interface class LibraryRepository {
  List<Movie> getMovies(CollectionType type);

  bool isInCollection(String movieId, CollectionType type);

  Future<void> toggle(Movie movie, CollectionType type);

  Future<void> clearAll();
}