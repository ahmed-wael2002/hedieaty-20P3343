import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  String _selectedColorHex = 'FF4081'; // Default color is pink

  // Getters
  bool get isDarkMode => _isDarkMode;
  bool get notificationsEnabled => _notificationsEnabled;
  String get selectedColorHex => _selectedColorHex;
  Color get selectedColor => Color(int.parse('0xFF$_selectedColorHex'));  // Ensure the color is in the correct format

  SettingsProvider() {
    _loadSettings(); // Load settings when the provider is created
  }

  // Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    _selectedColorHex = prefs.getString('selectedColorHex') ?? 'FF4081'; // Default pink

    notifyListeners();
  }

  // Save settings to SharedPreferences
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool('isDarkMode', _isDarkMode);
    prefs.setBool('notificationsEnabled', _notificationsEnabled);
    prefs.setString('selectedColorHex', _selectedColorHex);
  }

  // Methods to change settings
  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    _saveSettings();  // Save changes
    notifyListeners();
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    _saveSettings();  // Save changes
    notifyListeners();
  }

  void changeSelectedColor(Color color) {
    _selectedColorHex = color.value.toRadixString(16).substring(2).toUpperCase(); // Extract hex without '0x'
    _saveSettings();  // Save changes
    notifyListeners();
  }
}
