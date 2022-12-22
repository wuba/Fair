import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  static late SharedPreferences _sharedPreferences;

  static Future<SharedPreferences> initialized() {
    return SharedPreferences.getInstance()
        .then((value) => _sharedPreferences = value);
  }

  static Set<String> getKeys() => _sharedPreferences.getKeys();

  static Object? get(String key) => _sharedPreferences.get(key);

  static bool? getBool(String key) => _sharedPreferences.getBool(key);

  static int? getInt(String key) => _sharedPreferences.getInt(key);

  static double? getDouble(String key) => _sharedPreferences.getDouble(key);

  static String? getString(String key) => _sharedPreferences.getString(key);

  static Future<bool> setBool(String key, bool value) => _sharedPreferences.setBool(key, value);

  static Future<bool> setInt(String key, int value) => _sharedPreferences.setInt(key, value);

  static Future<bool> setDouble(String key, double value) => _sharedPreferences.setDouble(key, value);

  static Future<bool> setString(String key, String value) => _sharedPreferences.setString(key, value);

  static Future<bool> setStringList(String key, List<String> value) => _sharedPreferences.setStringList(key, value);

  static Future<bool> remove(String key) => _sharedPreferences.remove(key);

  static Future<bool> clear() => _sharedPreferences.clear();
}
