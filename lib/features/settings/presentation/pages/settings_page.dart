import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state_management/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Dark Mode Toggle
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: settingsProvider.isDarkMode,
              onChanged: (value) {
                settingsProvider.toggleDarkMode(value); // Update dark mode setting
              },
            ),
            const Divider(),

            // Notifications Toggle
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: settingsProvider.notificationsEnabled,
              onChanged: (value) {
                settingsProvider.toggleNotifications(value); // Update notifications setting
              },
            ),
            const Divider(),

            // Color Selector Dropdown
            ListTile(
              title: const Text('Select Color'),
              subtitle: Text('Current color: ${settingsProvider.selectedColor}'),
              trailing: DropdownButton<String>(
                value: settingsProvider.selectedColorHex, // Use the getter for color hex
                onChanged: (String? newColorHex) {
                  if (newColorHex != null) {
                    // Convert the selected hex back to a Color
                    Color newColor = Color(int.parse('0xFF$newColorHex'));
                    settingsProvider.changeSelectedColor(newColor); // Update selected color
                  }
                },
                items: [
                  DropdownMenuItem<String>(
                    value: 'FF4081', // Hex color value for pink
                    child: Container(width: 24, height: 24, color: Colors.pink),
                  ),
                  DropdownMenuItem<String>(
                    value: '4CAF50', // Hex color value for green
                    child: Container(width: 24, height: 24, color: Colors.green),
                  ),
                  DropdownMenuItem<String>(
                    value: '2196F3', // Hex color value for blue
                    child: Container(width: 24, height: 24, color: Colors.blue),
                  ),
                  DropdownMenuItem<String>(
                    value: '9C27B0', // Hex color value for purple
                    child: Container(width: 24, height: 24, color: Colors.purple),
                  ),
                ],
              ),
            ),
            const Divider(),

            // About Section
            ListTile(
              title: const Text('About'),
              subtitle: const Text('Learn more about this app'),
              onTap: () {
                // Navigate to an "About" page or show a dialog
                showAboutDialog(
                  context: context,
                  applicationName: 'Hedieaty App',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2024 Ahmed Wael',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
