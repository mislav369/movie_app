import 'package:hive_ce/hive.dart';
import 'package:movie_app/data/local/movie_entity.dart';
import 'package:movie_app/domain/model/collection_type.dart';
import 'package:movie_app/domain/model/movie.dart';
import 'package:movie_app/domain/repository/library_repository.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  final Box<MovieEntity> _box;

  LibraryRepositoryImpl(this._box);

  @override
  List<Movie> getMovies(CollectionType type) {
    return _box.values
        .where((entity) => entity.has(type))
        .map((entity) => entity.toDomain())
        .toList();
  }

  @override
  bool isInCollection(String movieId, CollectionType type) {
    final entity = _box.get(movieId);

    return entity != null && entity.has(type);
  }

  @override
  Future<void> toggle(Movie movie, CollectionType type) async {
    final existing = _box.get(movie.id);

    if (existing == null) {
      final entity = MovieEntity.fromDomain(movie);
      entity.collections.add(type.index);

      await _box.put(movie.id, entity);
      return;
    }

    if (existing.has(type)) {
      existing.collections.remove(type.index);

      if (existing.collections.isEmpty) {
        await existing.delete();
      } else {
        await existing.save();
      }

      return;
    }

    existing.collections.add(type.index);
    await existing.save();
  }

  @override
  Future<void> clearAll() {
    return _box.clear();
  }
}