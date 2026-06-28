import 'package:flutter/material.dart';
import 'package:movie_app/domain/model/movie.dart';
import 'package:movie_app/presentation/auth/screen/sign_in_screen.dart';
import 'package:movie_app/presentation/auth/screen/splash_screen.dart';
import 'package:movie_app/presentation/core/widget/main_navigation.dart';
import 'package:movie_app/presentation/details/screen/movie_details_screen.dart';
import 'package:movie_app/presentation/auth/screen/register_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String signIn = '/signIn';
  static const String home = '/home';
  static const String details = '/details';
  static const String register = '/register';

  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) {
            return const SplashScreen();
          },
        );

      case signIn:
        return MaterialPageRoute(
          builder: (_) {
            return const SignInScreen();
          },
        );

      case home:
        return MaterialPageRoute(
          builder: (_) {
            return const MainNavigation();
          },
        );

      case details:
        final movie = settings.arguments as Movie;

        return MaterialPageRoute(
          builder: (_) {
            return MovieDetailsScreen(movie: movie);
          },
        );

      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const SplashScreen();
          },
        );
    }
  }
}