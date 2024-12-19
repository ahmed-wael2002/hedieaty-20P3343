import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lecture_code/configs/theme/theme.dart';
import 'package:lecture_code/features/auth/presentation/pages/auth_wrapper.dart';

import 'features/notification/data/firebase_messaging/firebase_messaging_api.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase Initializations
  await Firebase.initializeApp();
  await FirebaseAPI().initNotification();
  // Initialize Local Databases
  // Run Application
  runApp(const MyApp());

  // Fixing notification issue
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final customTheme = CustomTheme();
    return MaterialApp(
      title: 'Hedieaty',
      theme: customTheme.lightThemeData(context),
      darkTheme: customTheme.darkThemeData(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(),
    );
  }
}
