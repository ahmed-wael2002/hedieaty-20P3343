// Packages
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

// Pages
import '../../../../Pages/ProfilePage.dart';
import '../../../../Utils/CreateEventForm.dart';
import '../../../../Utils/profile_widget.dart';
import '../../../../Utils/friends_list_view.dart';
// import '../Utils/header.dart';
import '../../../../Utils/CreateUserForm.dart';
import '../../../../Utils/events_list_view.dart';
import '../../../../Logic/event.dart';
import '../../../../Logic/user.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title, required this.logoutCallback});
  final String title;
  Function() logoutCallback;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late User user;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    user = User(
      'Ahmed Wael',
      'ahmedwael@gmail.com',
      '123',
      'assets/images/Ahmed Wael.jpg',
    );
  }

  void _showCreateUserDialog(BuildContext context) async {
    final User? newUser = await showDialog<User>(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Create New User'),
          content: CreateUserForm(),
        );
      },
    );
    if (newUser != null) {
      setState(() {
        user.addFriend(newUser);
      });
    }
  }

  void _showCreateEventDialog(BuildContext context) async {
    final Event? newEvent = await showDialog<Event>(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Create a new Event'),
          content: CreateEventForm(),
        );
      },
    );
    if (newEvent != null) {
      setState(() {
        user.addEvent(newEvent);
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentView;

    switch (_selectedIndex) {
      case 0: // Friends section
        currentView = FriendsList(user.friendsList);
        break;
      case 1: // Events section
        currentView = EventsList(user.eventsList);
        break;
      default: // Home/Profile section
        currentView = const FlutterLogo();
        break;
    }

    return Scaffold(
      // appBar: const Header(),
      appBar: AppBar(title: const Text('Hedieaty'),),
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(height: 150,),
            const ListTile(title: Text('Profile Widget'),),
            const ListTile(title: Text('Profile Widget'),),
            const ListTile(title: Text('Profile Widget'),),
            GestureDetector(
              onTap: ()=>setState(() {
                widget.logoutCallback;
              }),
                child: const ListTile(title: Text('Logout'), leading: Icon(Icons.logout,),)
            )
          ],
        )
      ),
      body: Column(
        children: [
          // Add profile widget to the top
          // GestureDetector to navigate to ProfilePage on tapping on the widget
          GestureDetector(
            child: ProfileWidget(
              imageUrl: user.imageUrl,
              name: user.name,
              email: user.email,
            ),
            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfilePage(user: user))),
          ),
          Expanded(child: currentView),
        ],
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.person_add),
            label: 'Add Friend',
            onTap: () => _showCreateUserDialog(context),
          ),
          SpeedDialChild(
            child: const Icon(Icons.event),
            label: 'Add Event',
            onTap: () => _showCreateEventDialog(context),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Colors.white70,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
