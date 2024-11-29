import 'package:lecture_code/common/constants/shared_preferences_keys.dart';
import 'package:lecture_code/features/homepage/domain/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Utils/events_list_view.dart';
import '../../../../Utils/friends_list_view.dart';

class HomepageProvider extends ChangeNotifier {
  late UserEntity user;
  int selectedPageIndex = 0;
  Widget currentView;
  late List<Widget> navigationWidgets;

  Future<void> userLogOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLoggedInKey, false);
  }

  void navigateToPage(int index) {
    selectedPageIndex = index;
    currentView = navigationWidgets[selectedPageIndex];
    notifyListeners();
  }

  HomepageProvider() : currentView = const SizedBox.shrink() {
    user = UserEntity(
        'M09YK1ZaTwc16WfLetLU',
        'Ahmed Wael',
        'awael92@gmail.com',
        '01557000791',
        [],
        []
    );
    // Initialize the navigationWidgets
    navigationWidgets = [
      const FriendsList([]),
      const EventsList([]),
      const FlutterLogo(),
    ];
    // Set the default currentView to the first widget
    currentView = navigationWidgets[0];
  }
}
