import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/preferences/preferences_keys.dart';

class AppPreferences {
  SharedPreferences? _preferences;

  Future<bool> _init() async {
    _preferences ??= await SharedPreferences.getInstance();

    return true;
  }

  Future<bool> setMetricSystem(bool enable) async {
    if (_preferences == null) {
      await _init();
    }

    return await _preferences!.setBool(
      PreferencesKeys.metricSystem.identifier,
      enable,
    );
  }

  Future<bool> getMetricSystem() async {
    if (_preferences == null) {
      await _init();
    }

    return _preferences!.getBool(PreferencesKeys.metricSystem.identifier) ??
        true;
  }

  Future<bool> clear() async {
    if (_preferences == null) {
      await _init();
    }

    return await _preferences!.clear();
  }
}
