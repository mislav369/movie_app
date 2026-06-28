import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/di.dart';
import 'package:movie_app/domain/model/collection_type.dart';
import 'package:movie_app/domain/model/movie.dart';
import 'package:movie_app/presentation/library/notifier/state/library_state.dart';

class LibraryNotifier extends Notifier<LibraryState> {
  @override
  LibraryState build() {
    return _read();
  }

  LibraryState _read() {
    final repository = ref.read(libraryRepositoryProvider);

    return LibraryState(
      favorites: repository.getMovies(CollectionType.favorite),
      watchlist: repository.getMovies(CollectionType.watchlist),
    );
  }

  bool isIn(String movieId, CollectionType type) {
    return ref.read(libraryRepositoryProvider).isInCollection(movieId, type);
  }

  Future<void> toggle(Movie movie, CollectionType type) async {
    await ref.read(toggleCollectionUseCaseProvider)(movie, type);

    state = _read();
  }

  Future<void> clear() async {
    await ref.read(libraryRepositoryProvider).clearAll();

    state = _read();
  }
}