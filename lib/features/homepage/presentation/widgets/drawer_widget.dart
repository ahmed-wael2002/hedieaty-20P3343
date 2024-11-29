import 'package:flutter/material.dart';
import 'package:lecture_code/features/homepage/presentation/state_management/user_provider.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

// import '../../../auth/presentation/pages/auth_wrapper.dart';
import '../../../auth/presentation/pages/auth_wrapper.dart';
import '../../../auth/presentation/state_mgmt/auth_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LineAwesomeIcons.alternate_sign_out),
                SizedBox(width: 10,),
                Text('Logout')
              ],
            ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () => userProvider.setUser(authProvider.uid),
            child: const Text('Test User')
        ),

        const SizedBox(
          height: 20,
        ),

        ElevatedButton(onPressed: () {}, child: const Text('Logout')),
        const SizedBox(
          height: 20,
        ),
      ],
    )
    );
  }
}
