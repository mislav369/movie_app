import 'package:movie_app/domain/model/movie.dart';
import 'package:movie_app/domain/model/result.dart';

abstract interface class MovieRepository {
  Future<Result<List<Movie>>> getPopularMovies();

  Future<Result<List<Movie>>> searchMovies(String query);

  Future<Result<Movie>> getMovieDetails(String id);
}