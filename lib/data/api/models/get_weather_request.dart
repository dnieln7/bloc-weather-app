class GetWeatherRequest {
  final double latitude;
  final double longitude;
  final bool useMetricSystem;

  GetWeatherRequest({
    required this.latitude,
    required this.longitude,
    required this.useMetricSystem,
  });
}
