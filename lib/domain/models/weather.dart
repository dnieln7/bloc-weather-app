import 'package:weather_app/domain/enums/enums.dart';

class Weather {
  final WeatherType weatherType;
  final TemperatureType temperatureType;
  final int minTemperature;
  final int temperature;
  final int maxTemperature;

  Weather({
    required this.weatherType,
    required this.temperatureType,
    required this.minTemperature,
    required this.temperature,
    required this.maxTemperature,
  });
}
