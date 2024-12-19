import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../state_management/homepage_provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final homepageProvider = Provider.of<HomepageProvider>(context, listen: false);
    final color = Theme.of(context).colorScheme.primary;
    return FlashyTabBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      animationCurve: Curves.linear,
      selectedIndex: Provider.of<HomepageProvider>(context).selectedPageIndex,
      iconSize: 30,
      showElevation: false, // use this to remove appBar's elevation
      onItemSelected: (index) => homepageProvider.navigateToPage(index),
      items: [
        customTabItem(
          color: color,
          icon: const Icon(LineAwesomeIcons.user,),
          title: 'Friends',
        ),
        customTabItem(
          color: color,
          icon: const Icon(LineAwesomeIcons.calendar,),
          title: 'Events',
        ),
        customTabItem(
          color: color,
          icon: const Icon(LineAwesomeIcons.gift,),
          title: 'Gifts',
        ),
        customTabItem(
          color: color,
          icon: const Icon(LineAwesomeIcons.lock,),
          title: 'Private',
        )
      ],
    );
  }
  FlashyTabBarItem customTabItem({
    required Color color,
    required Icon icon,
    required String title,
  }) {
    return FlashyTabBarItem(
      activeColor: color,
      inactiveColor: color,
      icon: icon,
      title: Text(title),
    );
  }
}
