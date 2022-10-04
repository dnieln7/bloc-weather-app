import 'package:weather_app/data/preferences/preferences.dart';

abstract class ISettingsRepository {
  Future<bool> setMetricSystem(bool enable);

  Future<bool> getMetricSystem();

  Future<bool> clearPreferences();
}

class SettingsRepository implements ISettingsRepository {
  final AppPreferences _preferences;

  SettingsRepository({required AppPreferences preferences})
      : _preferences = preferences;

  @override
  Future<bool> setMetricSystem(bool enable) {
    return _preferences.setMetricSystem(enable);
  }

  @override
  Future<bool> getMetricSystem() {
    return _preferences.getMetricSystem();
  }

  @override
  Future<bool> clearPreferences() {
    return _preferences.clear();
  }
}
