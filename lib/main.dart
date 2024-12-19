import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lecture_code/configs/theme/theme.dart';
import 'features/auth/presentation/pages/auth_wrapper.dart';

import 'common/shared_preferences/shared_preferences_singleton.dart';
import 'features/settings/presentation/state_management/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Initialize SharedPreferences
  await SharedPrefs().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final customTheme = CustomTheme();
    return ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
          return MaterialApp(
            title: 'Hedieaty',
            theme: customTheme.lightThemeData(context),
            darkTheme: customTheme.darkThemeData(),
            themeMode: settingsProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light, // Apply theme mode dynamically
            debugShowCheckedModeBanner: false,
            home: const AuthWrapper(),
          );
        },
      ),
    );
  }
}
