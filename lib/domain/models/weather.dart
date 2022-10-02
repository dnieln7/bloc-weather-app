import 'package:weather_app/domain/enums/enums.dart';

class Weather {
  final WeatherType weatherType;
  final TemperatureType temperatureType;
  final double minTemperature;
  final double temperature;
  final double maxTemperature;

  Weather({
    required this.weatherType,
    required this.temperatureType,
    required this.minTemperature,
    required this.temperature,
    required this.maxTemperature,
  });
}
