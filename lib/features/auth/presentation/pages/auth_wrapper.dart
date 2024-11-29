import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lecture_code/features/homepage/presentation/pages/home_page.dart';
import 'package:lecture_code/features/auth/presentation/pages/login_page.dart';
import 'package:lecture_code/features/auth/presentation/state_mgmt/auth_provider.dart';
import 'package:lecture_code/features/homepage/presentation/state_management/user_provider.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Builder(
        builder: (context) {
          final authProvider = Provider.of<AuthProvider>(context, listen: true);
          final userProvider = Provider.of<UserProvider>(context, listen: false);

          // Initialize the user in UserProvider if logged in
          if (authProvider.isLoggedIn && userProvider.user == null) {
            userProvider.setUser(authProvider.uid);
          }

          // Return the appropriate page based on login status
          return authProvider.isLoggedIn ? const MyHomePage() : LoginPage();
        },
      ),
    );
  }
}
