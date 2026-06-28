import 'package:movie_app/data/local/settings_local.dart';
import 'package:movie_app/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocal _local;

  SettingsRepositoryImpl(this._local);

  @override
  bool get isDarkMode {
    return _local.isDarkMode;
  }

  @override
  Future<void> setDarkMode(bool value) {
    return _local.setDarkMode(value);
  }
}