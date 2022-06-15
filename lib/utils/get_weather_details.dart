import 'package:assistant/utils/global_context.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetWeatherDetails {
  static late Position position;
  static Future<bool> determinePosition() async {
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
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      const snackBar = SnackBar(
        content: Text('Location permission denied.'),
      );
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(snackBar);
      return false;
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      const snackBar = SnackBar(
        content: Text('Please enable your location services.'),
      );
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(snackBar);
      return false;
    }
    print("getting the data");
    position = await Geolocator.getCurrentPosition();
    print("position value");
    print(position);
    return true;
  }

  static void getLocation() async {
    bool fetchLocationData = await determinePosition();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (fetchLocationData) {
      sharedPreferences.setDouble('latitude', position.latitude);
      sharedPreferences.setDouble('longitude', position.longitude);
      print("passed value: pt 1");
      print(position.latitude);
      print(position.longitude);
    } else {
      sharedPreferences.setDouble('latitude', 28.6139);
      sharedPreferences.setDouble('longitude', 77.2090);
    }
  }
}
