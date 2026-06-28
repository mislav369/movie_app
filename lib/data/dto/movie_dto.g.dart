// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TitlesResponseDto _$TitlesResponseDtoFromJson(Map<String, dynamic> json) =>
    TitlesResponseDto(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => MovieDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

TitleDetailsResponseDto _$TitleDetailsResponseDtoFromJson(
  Map<String, dynamic> json,
) => TitleDetailsResponseDto(
  results: json['results'] == null
      ? null
      : MovieDto.fromJson(json['results'] as Map<String, dynamic>),
);

MovieDto _$MovieDtoFromJson(Map<String, dynamic> json) => MovieDto(
  id: json['id'] as String?,
  titleText: json['titleText'] == null
      ? null
      : TitleTextDto.fromJson(json['titleText'] as Map<String, dynamic>),
  releaseYear: json['releaseYear'] == null
      ? null
      : ReleaseYearDto.fromJson(json['releaseYear'] as Map<String, dynamic>),
  primaryImage: json['primaryImage'] == null
      ? null
      : PrimaryImageDto.fromJson(json['primaryImage'] as Map<String, dynamic>),
  ratingsSummary: json['ratingsSummary'] == null
      ? null
      : RatingsSummaryDto.fromJson(
          json['ratingsSummary'] as Map<String, dynamic>,
        ),
  plot: json['plot'] == null
      ? null
      : PlotDto.fromJson(json['plot'] as Map<String, dynamic>),
);

TitleTextDto _$TitleTextDtoFromJson(Map<String, dynamic> json) =>
    TitleTextDto(text: json['text'] as String?);

ReleaseYearDto _$ReleaseYearDtoFromJson(Map<String, dynamic> json) =>
    ReleaseYearDto(year: (json['year'] as num?)?.toInt());

PrimaryImageDto _$PrimaryImageDtoFromJson(Map<String, dynamic> json) =>
    PrimaryImageDto(url: json['url'] as String?);

RatingsSummaryDto _$RatingsSummaryDtoFromJson(Map<String, dynamic> json) =>
    RatingsSummaryDto(
      aggregateRating: (json['aggregateRating'] as num?)?.toDouble(),
    );

PlotDto _$PlotDtoFromJson(Map<String, dynamic> json) => PlotDto(
  plotText: json['plotText'] == null
      ? null
      : PlotTextDto.fromJson(json['plotText'] as Map<String, dynamic>),
);

PlotTextDto _$PlotTextDtoFromJson(Map<String, dynamic> json) =>
    PlotTextDto(plainText: json['plainText'] as String?);
