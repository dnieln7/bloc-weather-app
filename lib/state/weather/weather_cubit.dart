import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/repositories.dart';
import 'package:weather_app/domain/models/models.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherFetchState> {
  final LocationRepository _locationRepository;
  final WeatherRepository _weatherRepository;

  WeatherCubit(
      {required LocationRepository locationRepository,
      required WeatherRepository weatherRepository})
      : _locationRepository = locationRepository,
        _weatherRepository = weatherRepository,
        super(WeatherFetchLoading()) {
    _locationRepository.isServiceReady.listen((isReady) {
      if (isReady) {
        _getLocation();
      } else {
        _locationRepository.askPermissions();
      }
    });

    _locationRepository.init();
  }

  void _getLocation() async {
    emit(WeatherFetchLoading());

    try {
      final location = await _locationRepository.getLocation();

      _fetch(location);
    } catch (e) {
      emit(WeatherFetchError(error: '$e'));
    }
  }

  void refresh() {
    _getLocation();
  }

  Future<void> _fetch(UserLocation location) async {
    try {
      final result = await _weatherRepository.fetchWeather(
        location.latitude,
        location.longitude,
      );

      emit(WeatherFetchSuccess(weather: result, location: location));
    } catch (error) {
      emit(WeatherFetchError(error: '$error'));
    }
  }

  @override
  Future<void> close() {
    _locationRepository.dispose();
    return super.close();
  }
}
