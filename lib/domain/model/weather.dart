import 'package:weather_app/domain/enum/enums.dart';

class Weather {
  final WeatherType weatherType;
  final TemperatureType temperatureType;
  final int minTemperature;
  final int temperature;
  final int maxTemperature;
  final bool useMetricSystem;

  Weather({
    required this.weatherType,
    required this.temperatureType,
    required this.minTemperature,
    required this.temperature,
    required this.maxTemperature,
    required this.useMetricSystem,
  });
}
