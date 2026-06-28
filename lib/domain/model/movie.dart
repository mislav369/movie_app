class Movie {
  final String id;
  final String title;
  final String? posterUrl;
  final int? year;
  final double? rating;
  final String? plot;

  const Movie({
    required this.id,
    required this.title,
    this.posterUrl,
    this.year,
    this.rating,
    this.plot,
  });
}