// ignore_for_file: always_specify_types

import "package:detect_fake_location/detect_fake_location.dart";
import "package:easy_localization/easy_localization.dart";
import "package:geolocator/geolocator.dart";

class Locations {
  static Future<LongLat?> lastPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception("gps_is_inactive".tr());
    }

    LocationPermission locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied || locationPermission == LocationPermission.deniedForever) {
      locationPermission = await Geolocator.requestPermission();

      if (locationPermission == LocationPermission.denied || locationPermission == LocationPermission.deniedForever) {
        throw Exception("location_permission_is_denied".tr());
      }
    }

    bool isMock = await DetectFakeLocation().detectFakeLocation();

    if (isMock) {
      throw Exception("fake_location_is_detected".tr());
    }

    Position? position;

    try {
      position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          timeLimit: Duration(seconds: 5),
        ),
      );
    } catch (e) {
      position = await Geolocator.getLastKnownPosition();
    }

    if (position!.isMocked) {
      throw Exception("fake_location_is_detected".tr());
    }

    return LongLat(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  static double distanceBetween(double a, double b, double c, double d) {
    return Geolocator.distanceBetween(a, b, c, d);
  }
}

class LongLat {
  final double latitude;
  final double longitude;

  LongLat({required this.latitude, required this.longitude});
}
