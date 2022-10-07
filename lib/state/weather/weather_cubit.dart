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

  void refresh() {
    try {
      fetch(_lastLatitude!, _lastLongitude!);
    } on TypeError {
      print('Could not fetch, one or more arguments are null');
    }
  }

  void fetch(double latitude, double longitude) {
    emit(WeatherFetchLoading());

    _lastLatitude = latitude;
    _lastLongitude = longitude;

    _weatherRepository
        .fetchWeather(latitude, longitude)
        .then((result) => emit(WeatherFetchSuccess(data: result)))
        .catchError((error) => emit(WeatherFetchError(error: '$error')));
  }
}
