import 'package:flutter/material.dart';
import 'package:lecture_code/common/shared_preferences/shared_preferences_singleton.dart';

class SettingsProvider extends ChangeNotifier {
  // State variables to hold settings
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;

  bool get isDarkMode => _isDarkMode;
  bool get notificationsEnabled => _notificationsEnabled;

  // Constructor to load the saved settings when the provider is created
  SettingsProvider() {
    _loadSettings();
  }

  // Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    final sharedPrefs = SharedPrefs();
    _isDarkMode = sharedPrefs.get<bool>('isDarkMode', defaultValue: false) ?? false;
    _notificationsEnabled = sharedPrefs.get<bool>('notificationsEnabled', defaultValue: true) ?? true;
    notifyListeners(); // Notify listeners after loading the settings
  }

  // Save settings to SharedPreferences
  Future<void> _saveSetting(String key, bool value) async {
    await SharedPrefs().set<bool>(key, value);
  }

  // Update the dark mode setting and notify listeners
  Future<void> toggleDarkMode(bool value) async {
    _isDarkMode = value;
    await _saveSetting('isDarkMode', value);
    notifyListeners(); // Notify listeners when the setting changes
  }

  // Update the notifications setting and notify listeners
  Future<void> toggleNotifications(bool value) async {
    _notificationsEnabled = value;
    await _saveSetting('notificationsEnabled', value);
    notifyListeners(); // Notify listeners when the setting changes
  }
}
