import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:movie_app/data/client/api_config.dart';
import 'package:movie_app/data/client/firebase_auth_client.dart';
import 'package:movie_app/data/client/movie_rest_client.dart';
import 'package:movie_app/data/local/movie_entity.dart';
import 'package:movie_app/data/local/settings_local.dart';
import 'package:movie_app/data/repository/library_repository_impl.dart';
import 'package:movie_app/data/repository/movie_repository_impl.dart';
import 'package:movie_app/data/repository/settings_repository_impl.dart';
import 'package:movie_app/data/repository/user_repository_impl.dart';
import 'package:movie_app/domain/repository/library_repository.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';
import 'package:movie_app/domain/repository/settings_repository.dart';
import 'package:movie_app/domain/repository/user_repository.dart';
import 'package:movie_app/domain/usecase/get_movie_details_use_case.dart';
import 'package:movie_app/domain/usecase/get_popular_movies_use_case.dart';
import 'package:movie_app/domain/usecase/search_movies_use_case.dart';
import 'package:movie_app/domain/usecase/toggle_collection_use_case.dart';
import 'package:movie_app/domain/usecase/user_sign_in_use_case.dart';
import 'package:movie_app/domain/usecase/user_sign_out_use_case.dart';
import 'package:movie_app/domain/usecase/user_sign_up_use_case.dart';
import 'package:movie_app/presentation/library/notifier/library_notifier.dart';
import 'package:movie_app/presentation/library/notifier/state/library_state.dart';
import 'package:movie_app/presentation/movies/notifier/movie_list_notifier.dart';
import 'package:movie_app/presentation/movies/notifier/state/movie_list_state.dart';
import 'package:movie_app/presentation/settings/notifier/theme_notifier.dart';
import 'package:movie_app/presentation/auth/notifier/authentication_notifier.dart';
import 'package:movie_app/presentation/auth/notifier/state/authentication_state.dart';



final firebaseAuthClientProvider = Provider<FirebaseAuthClient>((ref) {
  return FirebaseAuthClient();
});

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      headers: {
        'X-RapidAPI-Key': ApiConfig.rapidApiKey,
        'X-RapidAPI-Host': ApiConfig.rapidApiHost,
      },
    ),
  );
});

final movieRestClientProvider = Provider<MovieRestClient>((ref) {
  return MovieRestClient(ref.watch(dioProvider));
});



final libraryBoxProvider = Provider<Box<MovieEntity>>((ref) {
  throw UnimplementedError('Override libraryBoxProvider in main.dart');
});

final settingsBoxProvider = Provider<Box<dynamic>>((ref) {
  throw UnimplementedError('Override settingsBoxProvider in main.dart');
});



final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(ref.watch(firebaseAuthClientProvider));
});

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  return MovieRepositoryImpl(ref.watch(movieRestClientProvider));
});

final libraryRepositoryProvider = Provider<LibraryRepository>((ref) {
  return LibraryRepositoryImpl(ref.watch(libraryBoxProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl(
    SettingsLocal(ref.watch(settingsBoxProvider)),
  );
});



final userSignInUseCaseProvider = Provider<UserSignInUseCase>((ref) {
  return UserSignInUseCase(ref.watch(userRepositoryProvider));
});

final userSignUpUseCaseProvider = Provider<UserSignUpUseCase>((ref) {
  return UserSignUpUseCase(ref.watch(userRepositoryProvider));
});

final userSignOutUseCaseProvider = Provider<UserSignOutUseCase>((ref) {
  return UserSignOutUseCase(ref.watch(userRepositoryProvider));
});

final getPopularMoviesUseCaseProvider = Provider<GetPopularMoviesUseCase>((ref) {
  return GetPopularMoviesUseCase(ref.watch(movieRepositoryProvider));
});

final searchMoviesUseCaseProvider = Provider<SearchMoviesUseCase>((ref) {
  return SearchMoviesUseCase(ref.watch(movieRepositoryProvider));
});

final getMovieDetailsUseCaseProvider = Provider<GetMovieDetailsUseCase>((ref) {
  return GetMovieDetailsUseCase(ref.watch(movieRepositoryProvider));
});

final toggleCollectionUseCaseProvider = Provider<ToggleCollectionUseCase>((ref) {
  return ToggleCollectionUseCase(ref.watch(libraryRepositoryProvider));
});



final movieListNotifierProvider =
NotifierProvider<MovieListNotifier, MovieListState>(() {
  return MovieListNotifier();
});

final libraryNotifierProvider =
NotifierProvider<LibraryNotifier, LibraryState>(() {
  return LibraryNotifier();
});

final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});

final authenticationNotifierProvider =
NotifierProvider<AuthenticationNotifier, AuthenticationState>(() {
  return AuthenticationNotifier();
});