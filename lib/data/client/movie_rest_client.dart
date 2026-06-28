import 'package:dio/dio.dart';
import 'package:movie_app/data/client/api_config.dart';
import 'package:movie_app/data/dto/movie_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'movie_rest_client.g.dart';

@RestApi(baseUrl: ApiConfig.baseUrl)
abstract class MovieRestClient {
  factory MovieRestClient(Dio dio, {String? baseUrl}) = _MovieRestClient;

  @GET('/titles')
  Future<TitlesResponseDto> getPopularMovies({
    @Query('list') String list = 'top_boxoffice_200',
    @Query('info') String info = 'base_info',
    @Query('limit') int limit = 20,
  });

  @GET('/titles/search/title/{title}')
  Future<TitlesResponseDto> searchMovies(
      @Path('title') String title, {
        @Query('info') String info = 'base_info',
        @Query('exact') bool exact = false,
      });

  @GET('/titles/{id}')
  Future<TitleDetailsResponseDto> getMovieDetails(
      @Path('id') String id, {
        @Query('info') String info = 'base_info',
      });
}