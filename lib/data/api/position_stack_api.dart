import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/data/api/models/models.dart';

import 'exceptions/api_exception.dart';

class PositionStackApi {
  final String _url;
  final String _key;
  final http.Client _client;

  PositionStackApi(
      {required String url, required String key, http.Client? client})
      : _url = url,
        _key = key,
        _client = client ?? http.Client();

  Future<GetReverseLocationResponse> getReverseLocation(GetReverseLocationRequest request) async {
    final uri = Uri.http(
      _url,
      '/v1/reverse',
      {
        'access_key': _key,
        'query': '${request.latitude},${request.longitude}',
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
    final parsed = GetReverseLocationResponse.fromMap(decoded);

    return parsed;
  }
}
