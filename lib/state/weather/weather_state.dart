part of 'weather_cubit.dart';

@immutable
abstract class WeatherFetchState {}

class WeatherFetchLoading extends WeatherFetchState {}

class WeatherFetchError extends WeatherFetchState {
  final String error;

  WeatherFetchError({required this.error});
}

class WeatherFetchSuccess extends WeatherFetchState {
  final Weather data;

  WeatherFetchSuccess({required this.data});
}
