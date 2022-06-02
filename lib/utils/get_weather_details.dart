import 'package:assistant/utils/global_context.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GetWeatherDetails {
  static Position? position;
  static Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        const snackBar = SnackBar(
          content: Text('Location permission denied.'),
        );
        ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
            .showSnackBar(snackBar);
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      const snackBar = SnackBar(
        content: Text('Location permission denied.'),
      );
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(snackBar);
      return null;
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      const snackBar = SnackBar(
        content: Text('Please enable your location services.'),
      );
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(snackBar);
      return null;
    }

    position = await Geolocator.getCurrentPosition();
  }

  static Position? getLocation() {
    return position;
  }
}
