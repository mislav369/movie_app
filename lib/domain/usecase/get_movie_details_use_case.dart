import 'package:movie_app/domain/model/movie.dart';
import 'package:movie_app/domain/model/result.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

class GetMovieDetailsUseCase {
  final MovieRepository _repository;

  GetMovieDetailsUseCase(this._repository);

  Future<Result<Movie>> call(String id) {
    return _repository.getMovieDetails(id);
  }
}