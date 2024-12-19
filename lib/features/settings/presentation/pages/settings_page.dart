import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../../../../common/shared_preferences/shared_preferences_singleton.dart';
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
