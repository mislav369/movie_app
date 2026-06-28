import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/di.dart';
import 'package:movie_app/domain/model/movie.dart';
import 'package:movie_app/domain/model/result.dart';

final movieDetailsProvider = FutureProvider.family<Movie, String>((ref, id) async {
  final result = await ref.read(getMovieDetailsUseCaseProvider)(id);

  return switch (result) {
    Ok<Movie>(value: final movie) => movie,
    Error<Movie>(error: final error) => throw error,
  };
});