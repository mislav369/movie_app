import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/di.dart';

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final isDarkMode = ref.read(settingsRepositoryProvider).isDarkMode;

    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggle(bool isDark) async {
    await ref.read(settingsRepositoryProvider).setDarkMode(isDark);

    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}