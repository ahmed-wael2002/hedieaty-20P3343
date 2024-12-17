import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lecture_code/configs/theme/theme.dart';
import 'package:lecture_code/features/auth/presentation/pages/auth_wrapper.dart';
import 'package:lecture_code/features/events/data/data_sources/local/events_local_singleton.dart';
import 'package:lecture_code/features/gifts/data/data_sources/local/gift_local_singleton.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase Initializations
  await Firebase.initializeApp();
  // Initialize Local Databases
  // Run Application
  runApp(const MyApp());
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
