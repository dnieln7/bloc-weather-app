class GetReverseLocationRequest {
  final double latitude;
  final double longitude;

  GetReverseLocationRequest({required this.latitude, required this.longitude});

  @override
  String toString() {
    return 'GetReverseLocationRequest{latitude: $latitude, longitude: $longitude}';
  }
}
