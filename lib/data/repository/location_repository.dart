import 'package:weather_app/data/api/models/models.dart';
import 'package:weather_app/data/api/position_stack_api.dart';
import 'package:weather_app/domain/models/models.dart';
import 'package:weather_app/services/location_service.dart';

abstract class ILocationRepository {
  Future<UserLocation> getLocation();
}

class LocationRepository implements ILocationRepository {
  final LocationService _locationService;
  final PositionStackApi _positionStackApi;

  LocationRepository({required PositionStackApi positionStackApi})
      : _locationService = LocationService(),
        _positionStackApi = positionStackApi;

  Stream<bool> get isServiceReady {
    return _locationService.ready;
  }

  void init() {
    _locationService.init();
  }

  void askPermissions() {
    _locationService.askPermissions();
  }

  @override
  Future<UserLocation> getLocation() async {
    final data = await _locationService.currentLocation;
    final response = await _positionStackApi.getReverseLocation(
      GetReverseLocationRequest(
        latitude: data.latitude!,
        longitude: data.longitude!,
      ),
    );

    final location = response.data.first;

    return UserLocation(
      latitude: location.latitude,
      longitude: location.longitude,
      name: location.name,
      locality: location.locality,
      region: location.region,
      regionCode: location.regionCode,
      country: location.country,
      countryCode: location.countryCode,
    );
  }

  void dispose() {
    _locationService.dispose();
  }
}
