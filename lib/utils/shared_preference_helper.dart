import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  // Singleton pattern
  static final SharedPreferenceHelper _instance = SharedPreferenceHelper._internal();

  factory SharedPreferenceHelper() {
    return _instance;
  }

  SharedPreferenceHelper._internal();

  // Save string
  Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Retrieve string
  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Save boolean
  Future<void> saveBoolean(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Retrieve boolean
  Future<bool?> getBoolean(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}
