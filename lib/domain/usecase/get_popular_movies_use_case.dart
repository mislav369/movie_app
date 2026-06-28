import 'package:movie_app/domain/model/movie.dart';
import 'package:movie_app/domain/model/result.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

class GetPopularMoviesUseCase {
  final MovieRepository _repository;

  GetPopularMoviesUseCase(this._repository);

  Future<Result<List<Movie>>> call() {
    return _repository.getPopularMovies();
  }
}