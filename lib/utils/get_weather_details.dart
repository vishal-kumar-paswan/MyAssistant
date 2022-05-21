import 'dart:convert';
import 'package:assistant/utils/global_context.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class GetWeatherDetails {
  double? latitude, longitude;

  Future _determinePosition() async {
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
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      const snackBar = SnackBar(
        content: Text('Location permission denied.'),
      );
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(snackBar);
      return;
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      const snackBar = SnackBar(
        content: Text('Please enable your location services.'),
      );
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(snackBar);
      return;
    }

    return await Geolocator.getCurrentPosition();
  }

  void getLocation() async {
    final position = await _determinePosition();

    if (position != null) {
      latitude = position.latitude;
      longitude = position.longitude;
    } else {
      // Kalyani latitude : 22.975084 | longitude : 88.434509
      latitude = 22.975084;
      longitude = 88.434509;
    }

    // WeatherModel? futureWeather = await fetchWeatherDetails();

    // return futureWeather;
  }

  Future<WeatherModel?> get fetchWeatherDetails async {
    getLocation();

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=6d7b8aa0f6a34dd44744f2dc19f95b2f&units=metric'));
    if (response.statusCode == 200) {
      print(response.body);
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      const snackBar = SnackBar(
        content: Text('Failed to load weather data'),
      );
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(snackBar);
      // throw Exception('Failed to load weather');
    }
    return null;
  }
}
