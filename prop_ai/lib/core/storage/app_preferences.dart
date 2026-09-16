import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

class AppPreferences {
  static late SharedPreferences _preferences;

  AppPreferences._();

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static bool get onboardingCompleted {
    return _preferences.getBool(AppConstants.onboardingKey) ?? false;
  }

  static Future<void> setOnboardingCompleted(bool value) async {
    await _preferences.setBool(AppConstants.onboardingKey, value);
  }

  static bool get locationSelected {
    return _preferences.getBool(AppConstants.locationSelectedKey) ?? false;
  }

  static Future<void> setLocationSelected(bool value) async {
    await _preferences.setBool(AppConstants.locationSelectedKey, value);
  }

  static String? get locationName {
    return _preferences.getString(AppConstants.locationNameKey);
  }

  static Future<void> setLocationName(String value) async {
    await _preferences.setString(AppConstants.locationNameKey, value);
  }

  static bool get isAuthenticated {
    return _preferences.getBool(AppConstants.authenticatedKey) ?? false;
  }

  static Future<void> setAuthenticated(bool value) async {
    await _preferences.setBool(AppConstants.authenticatedKey, value);
  }

  static Future<void> clear() async {
    await _preferences.clear();
  }
}
