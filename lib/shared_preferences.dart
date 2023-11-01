import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _name = 'name';    // Key for storing user's name in SharedPreferences
  static const _hasLogin = 'hasLogin'; // Key for storing login status in SharedPreferences

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance(); // Initialize SharedPreferences

  static Future setUser({
    String? name,
  }) async {
    await _preferences.setString(_name, name ?? ""); // Save the user's name in cache
  }

  static Future setIsLogin({required bool registered}) async {
    await _preferences.setBool(_hasLogin, registered);   // Save a boolean indicating if the user is logged in or not
  }

  static String get name => _preferences.getString(_name) ?? "";  // Getter for retrieving the user's name from cache

  static bool get hasLogin =>
      _preferences.getBool(_hasLogin) ?? false;  // Getter for retrieving the login status from cache

  static Future logout() async {
    await _preferences.remove(_name);  // Clear the user's name from cache on logout
    await _preferences.remove(_hasLogin); // Clear the login status from cache on logout
  }
}
