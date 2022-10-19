import 'dart:async';
import 'dart:developer' as logger;

import 'package:location/location.dart';

class LocationService {
  final Location _location;

  final StreamController<bool> _readyController = StreamController();

  Stream<bool> get ready {
    return _readyController.stream;
  }

  PermissionStatus _permissionStatus = PermissionStatus.denied;
  bool _enabled = false;

  bool get hasPermissions {
    return _permissionStatus == PermissionStatus.granted ||
        _permissionStatus == PermissionStatus.grantedLimited;
  }

  Future<LocationData> get currentLocation {
    return _location.getLocation();
  }

  LocationService() : _location = Location();

  void init() async {
    try {
      _permissionStatus = await _location.hasPermission();
      _enabled = await _location.serviceEnabled();

      final isReady = hasPermissions && _enabled;

      _readyController.add(isReady);
    } catch (e) {
      _readyController.add(false);
      logger.log("checkReady error: $e", name: runtimeType.toString());
    }
  }

  void askPermissions() async {
    try {
      _permissionStatus = await _location.hasPermission();
      _enabled = await _location.serviceEnabled();

      if (hasPermissions) {
        if (_enabled) {
          _readyController.add(true);
        } else {
          await _location.requestService();

          init();
          // askPermissions();
        }
      } else {
        await _location.requestPermission();

        init();
        // askPermissions();
      }
    } catch (e) {
      _readyController.add(false);
      logger.log("askPermissions error: $e", name: runtimeType.toString());
    }
  }

  void dispose() {
    _readyController.close();
  }
}
