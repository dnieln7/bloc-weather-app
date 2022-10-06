import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/repositories.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final ISettingsRepository _settingsRepository;

  SettingsCubit({required ISettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository,
        super(SettingsLoading());

  void getSettings() async {
    final useMetric = await _settingsRepository.getMetricSystem();

    if (state is SettingsLoading) {
      emit(SettingsLoaded(settings: AppSettings(useMetricSystem: useMetric)));
    } else if (state is SettingsLoaded) {
      emit(
        SettingsLoaded(
          settings: (state as SettingsLoaded)
              .settings
              .copyWith(useMetricSystem: useMetric),
        ),
      );
    }
  }

  void setMetricSystem(bool enable) async {
    final result = await _settingsRepository.setMetricSystem(enable);
    final SettingsState newState;

    if (result) {
      newState = SettingsLoaded(
        settings: (state as SettingsLoaded)
            .settings
            .copyWith(useMetricSystem: enable),
      );
    } else {
      newState = SettingsLoaded(
        settings: (state as SettingsLoaded).settings.copyWith(),
        errorUpdating: 'Could not update metric system',
      );
    }

    emit(newState);
  }
}
