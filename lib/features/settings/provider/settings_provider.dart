import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool _weatherNotifications = false;
  bool _scheduleNotifications = true;
  bool _governmentSupportNotifications = false;

  bool get weatherNotifications => _weatherNotifications;
  bool get scheduleNotifications => _scheduleNotifications;
  bool get governmentSupportNotifications => _governmentSupportNotifications;

  void setWeatherNotifications(bool value) {
    _weatherNotifications = value;
    notifyListeners();
  }

  void setScheduleNotifications(bool value) {
    _scheduleNotifications = value;
    notifyListeners();
  }

  void setGovernmentSupportNotifications(bool value) {
    _governmentSupportNotifications = value;
    notifyListeners();
  }
}
