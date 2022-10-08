import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/repositories.dart';
import 'package:weather_app/domain/models/models.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherFetchState> {
  final WeatherRepository _weatherRepository;

  double? _lastLatitude;
  double? _lastLongitude;

  WeatherCubit({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(WeatherFetchLoading()) {
    fetch(18.875, -96.875);
    // fetch(-96.875, 18.875);
  }

  Future<void> refresh() async {
    try {
      await fetch(_lastLatitude!, _lastLongitude!);
    } on TypeError {
      emit(
        WeatherFetchError(
          error: 'Could not fetch, one or more arguments are null',
        ),
      );
    }
  }

  Future<void> fetch(double latitude, double longitude) async {
    emit(WeatherFetchLoading());

    _lastLatitude = latitude;
    _lastLongitude = longitude;

    try {
      final result = await _weatherRepository.fetchWeather(latitude, longitude);

      emit(WeatherFetchSuccess(data: result));
    } catch (error) {
      emit(WeatherFetchError(error: '$error'));
    }
  }
}
