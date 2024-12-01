// Packages
import 'package:flutter/material.dart';
import 'package:lecture_code/features/homepage/presentation/state_management/homepage_provider.dart';
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
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: Builder(
        builder: (context) {
          final homepageProvider = Provider.of<HomepageProvider>(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Hedieaty'),
            ),
            drawer: const CustomDrawer(),
            body: Column(
              children: [
                GestureDetector(
                  child: const ProfileWidget(),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(user: homepageProvider.user),
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
