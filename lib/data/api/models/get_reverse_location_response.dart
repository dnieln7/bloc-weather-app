

class GetReverseLocationResponse {
  final List<ReverseLocationData> data;

  GetReverseLocationResponse({required this.data});

  factory GetReverseLocationResponse.fromMap(Map<String, dynamic> map) {
    final List<ReverseLocationData> data = [];

    (map['data'] as List<dynamic>).forEach((element) {
      data.add(ReverseLocationData.fromMap(element as Map<String, dynamic>));
    });

    return GetReverseLocationResponse(data: data);
  }

  @override
  String toString() {
    return 'GetReverseLocationResponse{data: $data}';
  }
}

class ReverseLocationData {
  final double latitude;
  final double longitude;
  final String name;
  final String locality;
  final String region;
  final String regionCode;
  final String country;
  final String countryCode;

  ReverseLocationData({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.locality,
    required this.region,
    required this.regionCode,
    required this.country,
    required this.countryCode,
  });

  factory ReverseLocationData.fromMap(Map<String, dynamic> map) {
    return ReverseLocationData(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      name: map['name'] as String,
      locality: map['locality'] as String,
      region: map['region'] as String,
      regionCode: map['region_code'] as String,
      country: map['country'] as String,
      countryCode: map['country_code'] as String,
    );
  }

  @override
  String toString() {
    return 'ReverseLocationData{latitude: $latitude, longitude: $longitude, name: $name, locality: $locality, region: $region, regionCode: $regionCode, country: $country, countryCode: $countryCode}';
  }
}
