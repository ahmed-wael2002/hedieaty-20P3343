import 'package:flutter/material.dart';
import 'package:lecture_code/features/homepage/domain/entity/user.dart';
import 'package:lecture_code/features/homepage/presentation/state_management/homepage_provider.dart';
import 'package:lecture_code/features/homepage/presentation/state_management/user_provider.dart';
import 'package:lecture_code/features/homepage/presentation/widgets/bottom_navigation_widget.dart';
import 'package:lecture_code/features/homepage/presentation/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';

// Pages
import '../../../../Pages/profile_page.dart';
import '../../../auth/presentation/state_mgmt/auth_provider.dart';
import '../widgets/profile_widget.dart';
import '../widgets/speeddial_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomepageProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: Builder(
        builder: (context) {
          final homepageProvider = Provider.of<HomepageProvider>(context, listen: true);
          final userProvider = Provider.of<UserProvider>(context, listen: true);
          final authProvider = Provider.of<AuthenticationProvider>(context, listen: true);

          final mockUser = UserEntity('uid', 'name', 'email', 'phoneNumber', [], []);

          // Set user and update friends list when authProvider.uid is available
          if (userProvider.user == null) {
            userProvider.setUser(authProvider.uid);
          }

          // Update the friends list only if the user is not null
          if (userProvider.user != null) {
            homepageProvider.updateFriends(userProvider.user!.friendsList);
          }

          // If the user data is still loading, show a loading indicator
          if (userProvider.user == null) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Hedieaty'),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Hedieaty'),
            ),
            drawer: const CustomDrawer(),
            body: Column(
              children: [
                GestureDetector(
                  child: ProfileWidget(user: userProvider.user ?? mockUser),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(user: userProvider.user ?? mockUser),
                    ),
                  ),
                ),
                Expanded(child: homepageProvider.currentView),
              ],
            ),
            floatingActionButton: const SpeeddialButton(),
            bottomNavigationBar: const CustomBottomNavigationBar(),
          );
        },
      ),
    );
  }
}