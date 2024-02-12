import 'dart:async';
import 'dart:math';

import 'package:fl_location/fl_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {

  Future<LatLng?> getDeviceCurrentLocation(
      {LocationAccuracy accuracy = LocationAccuracy.best}) async {
    if (await checkAndRequestPermission()) {
      Location location = await FlLocation.getLocation(
          accuracy: accuracy); // TODO: Handle location throwing error
      return LatLng(location.latitude, location.longitude);
    }
    return null;
  }

  Stream<Location>? _locationStream;

  Stream<Location>? listenLocationStream() {
    if (_locationStream != null) {
      cancelLocationSubscription();
    }
    // Location will be updated on every 10 seconds or 200 meters
    _locationStream =
        FlLocation.getLocationStream(interval: 3 * 1000, )
            .asBroadcastStream()
            .distinct();
    return _locationStream;
  }

  Future<void> cancelLocationSubscription() async {
    await _locationStream?.drain();
    _locationStream = null;
  }

  Future<bool> checkAndRequestPermission({bool isBackground = false}) async {
    // TODO: Handle location throwing error
    if (!await FlLocation.isLocationServicesEnabled) {
      // TODO: Location services are disabled Show Location enable dialogue
      return false;
    }
    LocationPermission locationPermission =
        await FlLocation.checkLocationPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      // TODO: Deal with denied for ever
      return false;
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await FlLocation
          .requestLocationPermission(); // Asking user permission

      if (locationPermission == LocationPermission.denied ||
          locationPermission == LocationPermission.deniedForever) {
        return false;
      }
    }
    if (isBackground && locationPermission == LocationPermission.whileInUse) {
      // TODO: Show a dialog asking for "Always" permission for background location stream
      locationPermission = await FlLocation
          .requestLocationPermission(); // Asking user permission
      if (locationPermission == LocationPermission.whileInUse ||
          locationPermission == LocationPermission.denied ||
          locationPermission == LocationPermission.deniedForever) {
        return false;
      }
    }
    return true;
  }

  _handleError(dynamic error, StackTrace stackTrace) {
    // TODO: Implement error handling
  }

  bool hasReachedDestination(LatLng currentLocation, LatLng destination) {
    double distanceInMeters = calculateDistance(currentLocation, destination);
    return distanceInMeters <= 1;
  }

  double calculateDistance(LatLng point1, LatLng point2) {
    double earthRadius = 6371000; // Earth radius in meters
    double lat1 = degreesToRadians(point1.latitude);
    double lat2 = degreesToRadians(point2.latitude);
    double deltaLat = degreesToRadians(point2.latitude - point1.latitude);
    double deltaLng = degreesToRadians(point2.longitude - point1.longitude);

    double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(lat1) * cos(lat2) * sin(deltaLng / 2) * sin(deltaLng / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  // Function to convert degrees to radians
  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}
