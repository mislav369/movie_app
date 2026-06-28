import 'package:movie_app/data/client/api_config.dart';
import 'package:movie_app/data/client/movie_rest_client.dart';
import 'package:movie_app/data/mapper/movie_mapper.dart';
import 'package:movie_app/domain/model/movie.dart';
import 'package:movie_app/domain/model/result.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRestClient _client;

  MovieRepositoryImpl(this._client);

  Result<T>? _keyGuard<T>() {
    if (!ApiConfig.hasKey) {
      return Result.error(Exception('Missing RapidAPI key.'));
    }

    return null;
  }

  @override
  Future<Result<List<Movie>>> getPopularMovies() async {
    final guard = _keyGuard<List<Movie>>();
    if (guard != null) return guard;

    try {
      final response = await _client.getPopularMovies();

      final movies = (response.results ?? [])
          .where((dto) => dto.id != null)
          .map((dto) => dto.toDomain())
          .toList();

      return Result.ok(movies);
    } catch (e) {
      return Result.error(Exception('Failed to load movies.'));
    }
  }

  @override
  Future<Result<List<Movie>>> searchMovies(String query) async {
    final guard = _keyGuard<List<Movie>>();
    if (guard != null) return guard;

    try {
      final response = await _client.searchMovies(Uri.encodeComponent(query));

      final movies = (response.results ?? [])
          .where((dto) => dto.id != null)
          .map((dto) => dto.toDomain())
          .toList();

      return Result.ok(movies);
    } catch (e) {
      return Result.error(Exception('Search failed.'));
    }
  }

  @override
  Future<Result<Movie>> getMovieDetails(String id) async {
    final guard = _keyGuard<Movie>();
    if (guard != null) return guard;

    try {
      final response = await _client.getMovieDetails(id);
      final dto = response.results;

      if (dto == null) {
        return Result.error(Exception('Movie not found.'));
      }

      return Result.ok(dto.toDomain());
    } catch (e) {
      return Result.error(Exception('Failed to load movie details.'));
    }
  }
}