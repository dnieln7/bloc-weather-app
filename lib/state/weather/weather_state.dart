part of 'weather_cubit.dart';

@immutable
abstract class WeatherFetchState {}

class WeatherFetchLoading extends WeatherFetchState {}

class WeatherFetchError extends WeatherFetchState {
  final String error;

  WeatherFetchError({required this.error});
}

class WeatherFetchSuccess extends WeatherFetchState {
  final Weather weather;
  final UserLocation location;

  WeatherFetchSuccess({required this.weather, required this.location});
}
