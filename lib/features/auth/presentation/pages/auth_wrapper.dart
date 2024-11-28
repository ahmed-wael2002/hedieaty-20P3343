import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lecture_code/features/homepage/presentation/pages/Homepage.dart';
import 'package:lecture_code/features/auth/presentation/pages/login_page.dart';
import 'package:lecture_code/features/auth/presentation/state_mgmt/login_provider.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Builder(
        builder: (context){
          final authProvider = Provider.of<AuthProvider>(context, listen: true);
          authProvider.checkIsLoggedIn();
          return authProvider.isLoggedIn ? MyHomePage(title: 'test', logoutCallback: (){}) : LoginPage();
        },
      )
    );
  }
}
