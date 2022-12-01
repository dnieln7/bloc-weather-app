import 'dart:convert';
import 'dart:developer' as logger;

import 'package:http/http.dart' as http;
import 'package:weather_app/data/server/server.dart';

class ReverseLocationApi {
  final String _url;
  final http.Client _client;

  ReverseLocationApi({required String url})
      : _url = url,
        _client = http.Client();

  Future<GetReverseLocationResponse> getReverseLocation(
    GetReverseLocationRequest request,
  ) async {
    final uri = Uri.https(
      _url,
      '/reverse',
      {
        'lat': '${request.latitude}',
        'lon': '${request.longitude}',
        'zoom': '10',
        'format': 'jsonv2',
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
      logger.log('Api internal error');

      parsed = const GetReverseLocationResponse(
        name: 'N/A',
        displayName: 'N/A',
        addressInfo: AddressInfo(
          city: 'N/A',
          postCode: 'N/A',
          country: 'N/A',
          countryCode: 'N/A',
        ),
      );
    }

    return parsed;
  }
}
