import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/data/server/exception/exceptions.dart';
import 'package:weather_app/data/server/request/requests.dart';
import 'package:weather_app/data/server/response/responses.dart';
import 'dart:developer' as logger;

class PositionStackApi {
  final String _url;
  final String _key;
  final http.Client _client;

  PositionStackApi({required String url, required String key})
      : _url = url,
        _key = key,
        _client = http.Client();

  Future<GetReverseLocationResponse> getReverseLocation(
      GetReverseLocationRequest request) async {
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

    GetReverseLocationResponse parsed;

    try {
      final decoded = jsonDecode(response.body) as Map<String, dynamic>;
      parsed = GetReverseLocationResponse.fromMap(decoded);
    } catch (e) {
      logger.log('Position stack api internal error');

      parsed = GetReverseLocationResponse(
        data: [
          ReverseLocationData(
            latitude: request.latitude,
            longitude: request.longitude,
            name: 'N/A',
            locality: 'N/A',
            region: 'N/A',
            regionCode: 'N/A',
            country: 'N/A',
            countryCode: 'N/A',
          )
        ],
      );
    }

    return parsed;
  }
}
