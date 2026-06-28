import 'package:movie_app/domain/model/collection_type.dart';
import 'package:movie_app/domain/model/movie.dart';
import 'package:movie_app/domain/repository/library_repository.dart';

class ToggleCollectionUseCase {
  final LibraryRepository _repository;

  ToggleCollectionUseCase(this._repository);

  Future<void> call(Movie movie, CollectionType type) {
    return _repository.toggle(movie, type);
  }
}