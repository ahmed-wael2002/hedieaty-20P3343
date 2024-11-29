import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../../auth/presentation/pages/auth_wrapper.dart';
import '../../../auth/presentation/pages/auth_wrapper.dart';
import '../../../auth/presentation/state_mgmt/auth_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
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
            child: const Text('Logout')),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(onPressed: () {}, child: const Text('Logout')),
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
