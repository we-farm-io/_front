import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance => _prefs;

  static Future<bool> get onboardingCompleted async {
    return _prefs.getBool('onboardingCompleted') ?? false;
  }

  static Future<void> setOnboardingCompleted(bool value) async {
    await _prefs.setBool('onboardingCompleted', value);
  }
}

