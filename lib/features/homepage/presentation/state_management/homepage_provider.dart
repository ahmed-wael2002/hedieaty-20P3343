import 'package:flutter/material.dart';

import '../../../../Utils/events_list_view.dart';
import '../widgets/friends_list_view.dart';
import '../../domain/entity/user.dart';

class HomepageProvider extends ChangeNotifier {

  // Homepage Management
  int selectedPageIndex = 0;
  Widget currentView;
  late List<Widget> navigationWidgets;
  List<UserEntity> friends = [];

  void navigateToPage(int index) {
    selectedPageIndex = index;
    currentView = navigationWidgets[selectedPageIndex];
    notifyListeners();
  }

  HomepageProvider() : currentView = const SizedBox.shrink() {
    // Initialize the navigationWidgets
    navigationWidgets = [
      FriendsList([]),
      const EventsList([]),
      const FlutterLogo(),
    ];
    // Set the default currentView to the first widget
    currentView = navigationWidgets[0];
  }

  void updateFriends(List<UserEntity> newFriends) {
    if (newFriends.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        friends = newFriends;
        navigationWidgets[0] = FriendsList(friends); // Update the FriendsList widget
        notifyListeners();
      });
    }
  }
}