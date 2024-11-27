import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lecture_code/Pages/Homepage.dart';
import 'package:lecture_code/features/auth/presentation/pages/login_page.dart';
import 'package:lecture_code/features/auth/presentation/state_mgmt/login_provider.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: Builder(
        builder: (context){
          final loginProvider = Provider.of<LoginProvider>(context, listen: true);
          return loginProvider.isLoggedIn ? MyHomePage(title: 'test', logoutCallback: (){}) : LoginPage();
        },
      )
    );
  }
}
