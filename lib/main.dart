import 'package:flutter/material.dart';
import 'package:lecture_code/Utils/CreateEventForm.dart';
import 'Logic/user.dart'; // Assuming you have the User class in this file
import 'Utils/profile_widget.dart';
import 'Utils/friends_list_view.dart';
import 'Utils/header.dart';
import './Pages/EventsPage.dart';
import 'Utils/CreateUserForm.dart';
import './Pages/FriendPage.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import './Utils/events_list_view.dart';
import './Logic/event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hedieaty',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        '/homepage': (context) => const MyHomePage(title: 'Hedieaty'),
        '/events': (context) => const Eventspage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late User user;
  List<User>? friends;
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    user = User(
      'Ahmed Wael',
      'ahmedwael@gmail.com',
      '123',
      'assets/images/Ahmed Wael.jpg',
    );
    setState(() {
      user.addEvent(Event('Wello\'s Birthday', 'birthday'));
    });
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
      switch (_selectedIndex) {
        case 2:
          Navigator.pushNamed(context, '/events');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: Column(
        children: [
          ProfileWidget(imageUrl: user.imageUrl, name: user.name),
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.people)),
              Tab(icon: Icon(Icons.event)),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                FriendsList(user.friendsList),
                EventsList(user.eventsList),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.purple[100],
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }
}
