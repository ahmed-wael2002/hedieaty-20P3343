import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './Pages/LoginPage.dart';
import './Pages/Homepage.dart';

void main() {
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
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
