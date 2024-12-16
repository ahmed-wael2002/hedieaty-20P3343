import 'package:flutter/material.dart';
import 'package:lecture_code/features/events/presentation/widgets/events_wrapper.dart';
import 'package:lecture_code/features/gifts/presentation/widgets/gifts_list_wrapper.dart';
import 'package:lecture_code/features/users/presentation/pages/friends_list_wrapper.dart';

class HomepageProvider extends ChangeNotifier {
  // PageController for managing page navigation
  final PageController pageController = PageController();

  // Current selected index
  int selectedPageIndex = 0;

  // List of navigation widgets
  late List<Widget> navigationWidgets;

  HomepageProvider() {
    // Initialize the navigation widgets
    navigationWidgets = [
      const FriendsWrapper(),
      const EventsWrapper(),
      const GiftsListWrapper(isEditable: true, event: null, userId: null,),
    ];
  }

  // Navigate to a specific page
  void navigateToPage(int index) {
    selectedPageIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }
}
