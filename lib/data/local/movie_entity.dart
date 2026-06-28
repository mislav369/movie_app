import 'package:hive_ce/hive.dart';
import 'package:movie_app/domain/model/collection_type.dart';
import 'package:movie_app/domain/model/movie.dart';

part 'movie_entity.g.dart';

@HiveType(typeId: 0)
class MovieEntity extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? posterUrl;

  @HiveField(3)
  final int? year;

  @HiveField(4)
  final double? rating;

  @HiveField(5)
  final String? plot;

  @HiveField(6)
  List<int> collections;

  MovieEntity({
    required this.id,
    required this.title,
    this.posterUrl,
    this.year,
    this.rating,
    this.plot,
    List<int>? collections,
  }) : collections = collections ?? [];

  factory MovieEntity.fromDomain(Movie movie) {
    return MovieEntity(
      id: movie.id,
      title: movie.title,
      posterUrl: movie.posterUrl,
      year: movie.year,
      rating: movie.rating,
      plot: movie.plot,
    );
  }

  Movie toDomain() {
    return Movie(
      id: id,
      title: title,
      posterUrl: posterUrl,
      year: year,
      rating: rating,
      plot: plot,
    );
  }

  bool has(CollectionType type) {
    return collections.contains(type.index);
  }
}