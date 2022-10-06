part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

@immutable
class SettingsLoading extends SettingsState {}

@immutable
class SettingsLoaded extends SettingsState {
  final AppSettings settings;
  final String? errorUpdating;

  SettingsLoaded({required this.settings, this.errorUpdating});
}

@immutable
class AppSettings {
  final bool useMetricSystem;

  const AppSettings({required this.useMetricSystem});

  AppSettings copyWith({
    bool? useMetricSystem,
  }) {
    return AppSettings(
      useMetricSystem: useMetricSystem ?? this.useMetricSystem,
    );
  }
}
