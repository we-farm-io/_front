// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_farm/features/weather/data/api_key.dart';
import 'package:weather/weather.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? _weather;
  Weather? get weather => _weather;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(Position position) async {
  _isLoading = true;
  notifyListeners();

  try {
    WeatherFactory wf = WeatherFactory(apiKey, language: Language.ENGLISH);
    _weather = await wf.currentWeatherByLocation(
      position.latitude,
      position.longitude,
    ); 
  } catch (e) {
    print("Error fetching weather: $e");
    _weather = null; 
  }

  _isLoading = false;
  notifyListeners();
}
}
