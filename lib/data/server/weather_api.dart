import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/data/server/exception/exceptions.dart';
import 'package:weather_app/data/server/request/requests.dart';
import 'package:weather_app/data/server/response/responses.dart';

class WeatherApi {
  final String _url;
  final http.Client _client;

  WeatherApi({required String url})
      : _url = url,
        _client = http.Client();

  Future<GetWeatherResponse> getWeather(GetWeatherRequest request) async {
    final imperialParameters = {
      'temperature_unit': 'fahrenheit',
      'windspeed_unit': 'mph',
      'precipitation_unit': 'inch',
    };

    final uri = Uri.https(
      _url,
      '/v1/forecast',
      {
        'latitude': '${request.latitude}',
        'longitude': '${request.longitude}',
        'current_weather': 'true',
        'daily': ['weathercode', 'temperature_2m_max', 'temperature_2m_min'],
        'timezone': 'UTC',
      }..addAll(request.useMetricSystem ? {} : imperialParameters),
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
