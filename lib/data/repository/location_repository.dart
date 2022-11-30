import 'package:weather_app/data/server/request/requests.dart';
import 'package:weather_app/data/server/servers.dart';
import 'package:weather_app/domain/model/models.dart';
import 'package:weather_app/service/services.dart';

abstract class ILocationRepository {
  Future<UserLocation> getLocation();
}

class LocationRepository implements ILocationRepository {
  final LocationService _locationService;
  final ReverseLocationApi _reverseLocationApi;

  LocationRepository({required ReverseLocationApi reverseLocationApi})
      : _locationService = LocationService(),
        _reverseLocationApi = reverseLocationApi;

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
    final response = await _reverseLocationApi.getReverseLocation(
      GetReverseLocationRequest(
        latitude: data.latitude!,
        longitude: data.longitude!,
      ),
    );

    return UserLocation(
      latitude: data.latitude!,
      longitude: data.longitude!,
      name: response.name,
      summarized: response.displayName,
      city: response.addressInfo.city,
      postCode: response.addressInfo.postCode,
      country: response.addressInfo.country,
      countryCode: response.addressInfo.countryCode,
    );
  }

  void dispose() {
    _locationService.dispose();
  }
}
