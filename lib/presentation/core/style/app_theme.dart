import 'package:flutter/material.dart';

const Color _seed = Color(0xFF6C4DF6);

ThemeData _build(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: _seed,
    brightness: brightness,
  );

  final base = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montserrat',
    colorScheme: scheme,
  );

  return base.copyWith(

    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      titleTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: scheme.onSurface,
      ),
    ),


    textTheme: base.textTheme.copyWith(
      headlineMedium:
      base.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
      headlineSmall:
      base.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
      titleLarge:
      base.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      titleMedium:
      base.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    ),

    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),


    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    ),


    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

final ThemeData lightTheme = _build(Brightness.light);
final ThemeData darkTheme = _build(Brightness.dark);