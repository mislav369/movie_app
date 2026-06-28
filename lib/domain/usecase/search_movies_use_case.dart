import 'package:movie_app/domain/model/movie.dart';
import 'package:movie_app/domain/model/result.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

class SearchMoviesUseCase {
  final MovieRepository _repository;

  SearchMoviesUseCase(this._repository);

  Future<Result<List<Movie>>> call(String query) {
    return _repository.searchMovies(query);
  }
}