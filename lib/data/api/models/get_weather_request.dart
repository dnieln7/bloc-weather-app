class GetWeatherRequest {
  final double longitude;
  final double latitude;
  final bool useMetricSystem;

  GetWeatherRequest({
    required this.longitude,
    required this.latitude,
    required this.useMetricSystem,
  });
}
