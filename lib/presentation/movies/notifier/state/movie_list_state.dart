import 'package:movie_app/domain/model/movie.dart';

sealed class MovieListState {}

class LoadingState extends MovieListState {}

class EmptyState extends MovieListState {}

class SuccessState extends MovieListState {
  final List<Movie> movies;

  SuccessState(this.movies);
}

class ErrorState extends MovieListState {
  final String message;

  ErrorState(this.message);
}