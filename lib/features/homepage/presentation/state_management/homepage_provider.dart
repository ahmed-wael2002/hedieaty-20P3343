import 'package:flutter/material.dart';
import 'package:lecture_code/features/homepage/presentation/widgets/Friends%20List/friends_list_wrapper.dart';

import '../../../../Utils/events_list_view.dart';
import '../widgets/Friends List/friends_list_view.dart';
import '../../domain/entity/user.dart';

class HomepageProvider extends ChangeNotifier {

  // Homepage Management
  int selectedPageIndex = 0;
  Widget currentView;
  late List<Widget> navigationWidgets;

  void navigateToPage(int index) {
    selectedPageIndex = index;
    currentView = navigationWidgets[selectedPageIndex];
    notifyListeners();
  }

  HomepageProvider() : currentView = const SizedBox.shrink() {
    // Initialize the navigationWidgets
    navigationWidgets = [
      const FriendsListView(),
      const EventsList([]),
      const FlutterLogo(),
    ];
    // Set the default currentView to the first widget
    currentView = navigationWidgets[0];
  }

}