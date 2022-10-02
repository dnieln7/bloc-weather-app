import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/api/exceptions/exceptions.dart';
import 'package:weather_app/data/api/models/models.dart';

class WeatherApi {
  final String _baseUrl = 'api.open-meteo.com';
  final http.Client _client;

  WeatherApi({http.Client? client}) : _client = client ?? http.Client();

  Future<GetWeatherResponse> getWeather() async {
    final uri = Uri.https(
      _baseUrl,
      '/v1/forecast',
      {
        'latitude': '18.875',
        'longitude': '-96.875',
        'current_weather': 'true',
        'daily': ['weathercode', 'temperature_2m_max', 'temperature_2m_min'],
        'timezone': 'UTC',
      },
    );

    final response = await _client.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode != 200) {
      throw ApiException(code: response.statusCode, message: response.body);
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final parsed = GetWeatherResponse.fromMap(decoded);

    return parsed;
  }
}
