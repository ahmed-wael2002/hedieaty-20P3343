import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _instance = SharedPrefs._internal();

  late SharedPreferences _prefs;

  // Private constructor for the singleton instance
  SharedPrefs._internal();

  // Factory constructor to return the same instance
  factory SharedPrefs() {
    return _instance;
  }

  // Initialize the SharedPreferences instance (call this in main() or at app startup)
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Get a value by key with a default fallback
  T? get<T>(String key, {T? defaultValue}) {
    if (_prefs.containsKey(key)) {
      return _prefs.get(key) as T?;
    }
    return defaultValue;
  }

  // Save a value by key
  Future<bool> set<T>(String key, T value) async {
    if (value is String) return await _prefs.setString(key, value);
    if (value is int) return await _prefs.setInt(key, value);
    if (value is bool) return await _prefs.setBool(key, value);
    if (value is double) return await _prefs.setDouble(key, value);
    if (value is List<String>) return await _prefs.setStringList(key, value);
    throw UnsupportedError("Type not supported for SharedPreferences");
  }

  // Remove a value by key
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  // Check if a key exists
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  // Clear all stored values
  Future<bool> clear() async {
    return await _prefs.clear();
  }
}
