import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/repositories.dart';
import 'package:weather_app/domain/models/models.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherFetchState> {
  final LocationRepository _locationRepository;
  final WeatherRepository _weatherRepository;

  // double? _lastLatitude;
  // double? _lastLongitude;

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
    try {
      final location = await _locationRepository.getLocation();

      _fetch(location.latitude, location.longitude);
    } catch (e) {
      emit(WeatherFetchError(error: '$e'));
    }
  }

  void refresh() {
    _getLocation();
    // try {
    //   await _fetch(_lastLatitude!, _lastLongitude!);
    // } on TypeError {
    //   emit(
    //     WeatherFetchError(
    //       error: 'Could not fetch, one or more arguments are null',
    //     ),
    //   );
    // }
  }

  Future<void> _fetch(double latitude, double longitude) async {
    emit(WeatherFetchLoading());

    // _lastLatitude = latitude;
    // _lastLongitude = longitude;

    try {
      final result = await _weatherRepository.fetchWeather(latitude, longitude);

      emit(WeatherFetchSuccess(data: result));
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
