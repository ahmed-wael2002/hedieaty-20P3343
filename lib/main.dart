import 'package:flutter/material.dart';
import 'Logic/user.dart'; // Assuming you have the User class in this file
import 'Utils/profile_widget.dart';
import 'Utils/friends_list_view.dart';
import 'Utils/header.dart';
import './Pages/EventsPage.dart';
import 'Utils/CreateUserForm.dart';
import './Pages/FriendPage.dart';

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
        '/events': (context) => Eventspage(),
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

class _MyHomePageState extends State<MyHomePage> {
  late User user;
  List<User>? friends;
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

  // Function to show the Create User dialog and get the newly created user back
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

    // If a new user is returned, add them to the friends list
    if (newUser != null) {
      setState(() {
        user.addFriend(newUser);
      });
    }
  }

  // Handle bottom navigation item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      switch(_selectedIndex){
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showCreateUserDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.add),
                    Text("Create a new Event/List"),
                  ],
                ),
              ),
            ),
            ProfileWidget(
              imageUrl: user.imageUrl,
              name: user.name,
            ),
            Expanded(
              child: FriendsList(user.friendsList),
            ),
          ],
        ),
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

