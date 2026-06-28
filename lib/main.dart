import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:movie_app/data/local/movie_entity.dart';
import 'package:movie_app/di.dart';
import 'package:movie_app/firebase_options.dart';
import 'package:movie_app/presentation/core/app_router.dart';
import 'package:movie_app/presentation/core/style/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(MovieEntityAdapter());

  final libraryBox = await Hive.openBox<MovieEntity>('library');
  final settingsBox = await Hive.openBox<dynamic>('settings');

  runApp(
    ProviderScope(
      overrides: [
        libraryBoxProvider.overrideWithValue(libraryBox),
        settingsBoxProvider.overrideWithValue(settingsBox),
      ],
      child: const MovieApp(),
    ),
  );
}

class MovieApp extends ConsumerWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      initialRoute: AppRouter.splash,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}