import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../state_management/homepage_provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final homepageProvider = Provider.of<HomepageProvider>(context, listen: false);
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(LineAwesomeIcons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(LineAwesomeIcons.calendar),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(LineAwesomeIcons.gift),
          label: 'Gifts',
        ),
      ],
      currentIndex: Provider.of<HomepageProvider>(context).selectedPageIndex,
      selectedItemColor: Theme.of(context).colorScheme.onPrimary,
      unselectedItemColor: Theme.of(context).colorScheme.surfaceDim,
      backgroundColor: Theme.of(context).colorScheme.primary,
      selectedFontSize: 14,
      unselectedFontSize: 12,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
      onTap: homepageProvider.navigateToPage, // Fixed onTap to call navigateToPage
    );
  }
}
