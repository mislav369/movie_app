import 'package:json_annotation/json_annotation.dart';

part 'movie_dto.g.dart';

@JsonSerializable(createToJson: false)
class TitlesResponseDto {
  final List<MovieDto>? results;

  TitlesResponseDto({
    this.results,
  });

  factory TitlesResponseDto.fromJson(Map<String, dynamic> json) {
    return _$TitlesResponseDtoFromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class TitleDetailsResponseDto {
  final MovieDto? results;

  TitleDetailsResponseDto({
    this.results,
  });

  factory TitleDetailsResponseDto.fromJson(Map<String, dynamic> json) {
    return _$TitleDetailsResponseDtoFromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class MovieDto {
  final String? id;
  final TitleTextDto? titleText;
  final ReleaseYearDto? releaseYear;
  final PrimaryImageDto? primaryImage;
  final RatingsSummaryDto? ratingsSummary;
  final PlotDto? plot;

  MovieDto({
    this.id,
    this.titleText,
    this.releaseYear,
    this.primaryImage,
    this.ratingsSummary,
    this.plot,
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) {
    return _$MovieDtoFromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class TitleTextDto {
  final String? text;

  TitleTextDto({
    this.text,
  });

  factory TitleTextDto.fromJson(Map<String, dynamic> json) {
    return _$TitleTextDtoFromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class ReleaseYearDto {
  final int? year;

  ReleaseYearDto({
    this.year,
  });

  factory ReleaseYearDto.fromJson(Map<String, dynamic> json) {
    return _$ReleaseYearDtoFromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class PrimaryImageDto {
  final String? url;

  PrimaryImageDto({
    this.url,
  });

  factory PrimaryImageDto.fromJson(Map<String, dynamic> json) {
    return _$PrimaryImageDtoFromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class RatingsSummaryDto {
  final double? aggregateRating;

  RatingsSummaryDto({
    this.aggregateRating,
  });

  factory RatingsSummaryDto.fromJson(Map<String, dynamic> json) {
    return _$RatingsSummaryDtoFromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class PlotDto {
  final PlotTextDto? plotText;

  PlotDto({
    this.plotText,
  });

  factory PlotDto.fromJson(Map<String, dynamic> json) {
    return _$PlotDtoFromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class PlotTextDto {
  final String? plainText;

  PlotTextDto({
    this.plainText,
  });

  factory PlotTextDto.fromJson(Map<String, dynamic> json) {
    return _$PlotTextDtoFromJson(json);
  }
}