import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lecture_code/configs/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/auth/presentation/pages/login_page.dart';
import './Pages/Homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  bool isLoggedIn = false;

  Future<void> checkIsLoggedIn() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? prefsVal = prefs.getBool('isLoggedIn');
    isLoggedIn = prefsVal ?? false;
  }

  Future<void> logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
  }

  @override
  Widget build(BuildContext context) {
    checkIsLoggedIn();
    return MaterialApp(
      title: 'Hedieaty',
      theme: themeData,
      debugShowCheckedModeBanner: false,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: const LoginPage(), // This line is for testing
      home: isLoggedIn ? MyHomePage(title: 'Flutter Demo Home Page',  logoutCallback: logout) : LoginPage(),
      routes: {
        '/homepage': (context) => MyHomePage(title: 'Hedieaty', logoutCallback: logout),
        // '/events': (context) => Eventspage(),
      },
    );
  }
}
