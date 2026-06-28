import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/di.dart';
import 'package:movie_app/domain/model/movie.dart';
import 'package:movie_app/domain/model/result.dart';
import 'package:movie_app/presentation/movies/notifier/state/movie_list_state.dart';

class MovieListNotifier extends Notifier<MovieListState> {
  @override
  MovieListState build() {
    load();
    return LoadingState();
  }

  Future<void> load() async {
    state = LoadingState();

    final result = await ref.read(getPopularMoviesUseCaseProvider)();

    _emit(result);
  }

  Future<void> search(String query) async {
    final cleanQuery = query.trim();

    if (cleanQuery.isEmpty) {
      return load();
    }

    state = LoadingState();

    final result = await ref.read(searchMoviesUseCaseProvider)(cleanQuery);

    _emit(result);
  }

  void _emit(Result<List<Movie>> result) {
    switch (result) {
      case Ok<List<Movie>>():
        state = result.value.isEmpty ? EmptyState() : SuccessState(result.value);

      case Error<List<Movie>>():
        state = ErrorState(
          result.error.toString().replaceFirst('Exception: ', ''),
        );
    }
  }
}