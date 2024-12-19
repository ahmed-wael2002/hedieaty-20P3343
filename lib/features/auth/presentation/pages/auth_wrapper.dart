// lib/features/auth/presentation/pages/auth_wrapper.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lecture_code/features/auth/presentation/pages/login_page.dart';
import 'package:lecture_code/features/homepage/presentation/pages/home_page.dart';
import 'package:lecture_code/features/users/presentation/state_management/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:lecture_code/features/auth/presentation/state_mgmt/auth_provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider<AuthenticationProvider>(
      // create: (_) => AuthenticationProvider(),
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Builder(
        builder: (context) {
          return StreamBuilder<User?>(
            // Listen to the FirebaseAuth authStateChanges stream
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final authProvider = Provider.of<AuthenticationProvider>(context);
              final userProvider = Provider.of<UserProvider>(context);

              // if(authProvider.isLoggedIn){
              //   return const MyHomePage();
              // }

              // Check if the connection is still active
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // If the user is logged in
              if (snapshot.hasData && snapshot.data != null) {
                Future.microtask(() => authProvider.setUserId(snapshot.data!.uid));
                if (authProvider.uid.isNotEmpty) {
                  userProvider.setUser(authProvider.uid);
                }
                return const MyHomePage();
              }

              // If no user is logged in
              return Consumer<AuthenticationProvider>(
                builder: (context, authProvider, child) {
                  if (authProvider.isSignedUp) {
                    // After successful signup, navigate to login page
                    return LoginPage();
                  } else {
                    // Default: Show the login page
                    return LoginPage();
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}