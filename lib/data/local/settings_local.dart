import 'package:hive_ce/hive.dart';

class SettingsLocal {
  static const String _darkModeKey = 'is_dark_mode';

  final Box _box;

  SettingsLocal(this._box);

  bool get isDarkMode {
    return _box.get(_darkModeKey, defaultValue: false) as bool;
  }

  Future<void> setDarkMode(bool value) {
    return _box.put(_darkModeKey, value);
  }
}