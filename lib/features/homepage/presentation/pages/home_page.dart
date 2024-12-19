import 'package:flutter/material.dart';
import 'package:lecture_code/features/gifts/presentation/state_management/gift_provider.dart';
import 'package:lecture_code/features/users/domain/entity/user.dart';
import 'package:lecture_code/features/homepage/presentation/state_management/homepage_provider.dart';
import 'package:lecture_code/features/users/presentation/pages/update_profile_page.dart';
import 'package:lecture_code/features/users/presentation/state_management/user_provider.dart';
import 'package:lecture_code/features/homepage/presentation/widgets/bottom_navigation_widget.dart';
import 'package:lecture_code/features/homepage/presentation/widgets/drawer_widget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

// Pages
// import '../../../users/presentation/pages/profile_page.dart';
import '../../../auth/presentation/state_mgmt/auth_provider.dart';
import '../../../events/presentation/state_management/event_provider.dart';
import '../../../users/presentation/widgets/profile_widget.dart';
import '../widgets/speeddial_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomepageProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => GiftProvider()),
      ],
      child: Builder(
        builder: (context) {
          final homepageProvider = Provider.of<HomepageProvider>(context, listen: true);
          final userProvider = Provider.of<UserProvider>(context, listen: true);
          final authProvider = Provider.of<AuthenticationProvider>(context, listen: true);
          final mockUser = UserEntity('uid', 'name', 'email', 'phoneNumber', [], [], 'fcmToken');

          // Set user and update friends list when authProvider.uid is available
          if (userProvider.user == null) {
            userProvider.setUser(authProvider.uid);
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

          // print('From home page: ${userProvider.user?.name}');

          return Scaffold(
            appBar: AppBar(
              title: const Text('Hedieaty'),
            ),
            drawer: const CustomDrawer(),
            body: LiquidPullToRefresh(
              animSpeedFactor: 1,
              showChildOpacityTransition: false,
              height: 100,
              springAnimationDurationInMilliseconds: 1000,
              // color: Theme.of(context).colorScheme.primary,
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.surface,
              onRefresh: () async {
                userProvider.setUser(authProvider.uid);
                // await Future.delayed(const Duration(seconds: 1));
              },
              child: Column(
                children: [
                  GestureDetector(
                    child: ProfileWidget(user: userProvider.user ?? mockUser),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider(create: (_) => UserProvider()),
                              ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
                            ],
                            child: UpdateProfilePage(user: userProvider.user ?? mockUser),
                        )
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      onPageChanged: (index) {
                        homepageProvider.setPageIndex(index);
                      },
                      controller: homepageProvider.pageController,
                      children: homepageProvider.navigationWidgets,
                    ),
                  )
                  // Expanded(child: homepageProvider.currentView),
                ],
              ),
            ),
            floatingActionButton: const SpeeddialButton(),
            bottomNavigationBar: const CustomBottomNavigationBar(),
          );
        },
      ),
    );
  }
}
