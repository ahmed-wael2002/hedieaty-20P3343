import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lecture_code/configs/theme/theme.dart';
import 'package:lecture_code/features/auth/presentation/pages/auth_wrapper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await Firebase.initializeApp();
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
