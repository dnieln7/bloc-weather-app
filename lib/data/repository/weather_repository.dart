import 'package:weather_app/data/preferences/preferences.dart';
import 'package:weather_app/data/server/server.dart';
import 'package:weather_app/domain/enum/enums.dart';
import 'package:weather_app/domain/model/models.dart';

abstract class IWeatherRepository {
  Future<Weather> fetchWeather(double longitude, double latitude);
}

class WeatherRepository implements IWeatherRepository {
  final AppPreferences _preferences;
  final WeatherApi _weatherApi;

  WeatherRepository({
    required AppPreferences preferences,
    required WeatherApi weatherApi,
  })  : _preferences = preferences,
        _weatherApi = weatherApi;

  @override
  Future<Weather> fetchWeather(double latitude, double longitude) async {
    final useMetricSystem = await _preferences.getMetricSystem();
    final response = await _weatherApi.getWeather(GetWeatherRequest(
      latitude: latitude,
      longitude: longitude,
      useMetricSystem: useMetricSystem,
    ));

    final TemperatureType temperatureType = useMetricSystem
        ? _getMetricTemperatureType(response.currentWeather.temperature)
        : _getTemperatureType(response.currentWeather.temperature);

    return Weather(
      weatherType: _getWeatherType(response.currentWeather.weatherCode.toInt()),
      temperatureType: temperatureType,
      minTemperature: response.dailyWeather.temperature2mMin.first.round(),
      temperature: response.currentWeather.temperature.round(),
      maxTemperature: response.dailyWeather.temperature2mMax.first.round(),
      useMetricSystem: useMetricSystem,
    );
  }

  WeatherType _getWeatherType(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return WeatherType.clearSky;
      case 1:
      case 2:
      case 3:
        return WeatherType.cloudy;
      case 45:
      case 48:
        return WeatherType.fog;
      case 51:
      case 53:
      case 55:
        return WeatherType.drizzle;
      case 56:
      case 57:
        return WeatherType.freezingDrizzle;
      case 61:
      case 63:
      case 65:
        return WeatherType.rain;
      case 66:
      case 67:
        return WeatherType.freezingRain;
      case 71:
      case 73:
      case 75:
        return WeatherType.snowFall;
      case 77:
        return WeatherType.snowGrains;
      case 80:
      case 81:
      case 82:
        return WeatherType.rainShower;
      case 85:
      case 86:
        return WeatherType.snowShower;
      case 95:
        return WeatherType.thunderstorm;
      case 96:
      case 99:
        return WeatherType.hailThunderstorm;
      default:
        return WeatherType.unknown;
    }
  }

  TemperatureType _getMetricTemperatureType(double temperature) {
    if (temperature > 35) {
      return TemperatureType.veryHot;
    } else if (temperature > 25) {
      return TemperatureType.hot;
    } else if (temperature > 15) {
      return TemperatureType.neutral;
    } else if (temperature > 0) {
      return TemperatureType.cold;
    } else {
      return TemperatureType.veryCold;
    }
  }

  TemperatureType _getTemperatureType(double temperature) {
    if (temperature > 95) {
      return TemperatureType.veryHot;
    } else if (temperature > 77) {
      return TemperatureType.hot;
    } else if (temperature > 59) {
      return TemperatureType.neutral;
    } else if (temperature > 32) {
      return TemperatureType.cold;
    } else {
      return TemperatureType.veryCold;
    }
  }
}
