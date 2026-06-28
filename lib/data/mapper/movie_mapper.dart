import 'package:movie_app/data/dto/movie_dto.dart';
import 'package:movie_app/domain/model/movie.dart';

extension MovieDtoMapper on MovieDto {
  Movie toDomain() {
    return Movie(
      id: id ?? '',
      title: titleText?.text ?? 'Untitled',
      posterUrl: primaryImage?.url,
      year: releaseYear?.year,
      rating: ratingsSummary?.aggregateRating,
      plot: plot?.plotText?.plainText,
    );
  }
}