class GetWeatherResponse {
  final CurrentWeatherResponse currentWeather;
  final DailyWeatherResponse dailyWeather;

  GetWeatherResponse({
    required this.currentWeather,
    required this.dailyWeather,
  });

  factory GetWeatherResponse.fromMap(Map<String, dynamic> map) {
    return GetWeatherResponse(
      currentWeather: CurrentWeatherResponse.fromMap(map['current_weather']),
      dailyWeather: DailyWeatherResponse.fromMap(map['daily']),
    );
  }

  @override
  String toString() {
    return 'GetWeatherResponse{currentWeather: $currentWeather, dailyWeather: $dailyWeather}';
  }
}

class CurrentWeatherResponse {
  final double temperature;
  final double weatherCode;

  CurrentWeatherResponse({
    required this.temperature,
    required this.weatherCode,
  });

  factory CurrentWeatherResponse.fromMap(Map<String, dynamic> map) {
    return CurrentWeatherResponse(
      temperature: map['temperature'] as double,
      weatherCode: map['weathercode'] as double,
    );
  }

  @override
  String toString() {
    return 'CurrentWeatherResponse{temperature: $temperature, weatherCode: $weatherCode}';
  }
}

class DailyWeatherResponse {
  final List<double> temperature2mMax;
  final List<double> temperature2mMin;

  DailyWeatherResponse({
    required this.temperature2mMax,
    required this.temperature2mMin,
  });

  factory DailyWeatherResponse.fromMap(Map<String, dynamic> map) {
    return DailyWeatherResponse(
      temperature2mMax: (map['temperature_2m_max'] as List<dynamic>)
          .map((e) => e as double)
          .toList(),
      temperature2mMin: (map['temperature_2m_min'] as List<dynamic>)
          .map((e) => e as double)
          .toList(),
    );
  }

  @override
  String toString() {
    return 'DailyWeatherResponse{temperature2mMax: $temperature2mMax, temperature2mMin: $temperature2mMin}';
  }
}
