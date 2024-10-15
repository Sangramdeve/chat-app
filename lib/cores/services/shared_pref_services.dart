import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  static Future<void> savePreference(key, dynamic value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (value is String) {
      await preferences.setString(key, value);
    } else if (value is bool) {
      await preferences.setBool(key, value);
    } else if (value is int) {
      await preferences.setInt(key, value);
    } else if (value is double) {
      await preferences.setDouble(key, value);
    } else {
      throw Exception('Unsupported value type');
    }
  }

  static Future<dynamic> getPreference(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(key)) {
      dynamic value = preferences.get(key);
      return value;
    }
    return null;
  }

  static Future<void> clearPreference(key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }
}
