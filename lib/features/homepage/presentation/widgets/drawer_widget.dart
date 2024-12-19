import 'package:flutter/material.dart';
import 'package:lecture_code/features/settings/presentation/pages/settings_page.dart';
import 'package:lecture_code/features/users/presentation/state_management/user_provider.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../auth/presentation/pages/auth_wrapper.dart';
import '../../../auth/presentation/state_mgmt/auth_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context, listen: true);
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    return Drawer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              authProvider.logout();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AuthWrapper()));
            },
            child: const Text('Logout')
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () => userProvider.setUser(authProvider.uid),
            child: const Text('Reload User Details')
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage())),
            child: const Text('Settings')
        ),

        const SizedBox(
          height: 20,
        ),

        const SizedBox(
          height: 20,
        ),
      ],
    )
    );
  }
}
