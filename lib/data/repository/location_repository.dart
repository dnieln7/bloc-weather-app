import 'package:weather_app/domain/models/models.dart';
import 'package:weather_app/services/location_service.dart';

abstract class ILocationRepository {
  Future<UserLocation> getLocation();
}

class LocationRepository implements ILocationRepository {
  final LocationService _locationService;

  LocationRepository() : _locationService = LocationService();

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

    return UserLocation(latitude: data.latitude!, longitude: data.longitude!);
  }

  void dispose() {
    _locationService.dispose();
  }
}
