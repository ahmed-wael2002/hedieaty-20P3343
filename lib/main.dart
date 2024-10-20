import 'dart:convert';

import 'package:flutter/material.dart';
import 'profile_card.dart';
import 'profile_widget.dart';
import 'list_of_friends.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hedieaty',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  // _ indicates the variable is private
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // private integer data member
  int _counter = 0;
  static const String __name = 'Ahmed Wael is telling you';

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    print('Stateful widget -- initState');
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Title is formatted to be bold
        title: const Text("Hedieaty",
            style: TextStyle(fontWeight: FontWeight.w500)),
        elevation: 0,
        // Leading for placing icons to the left side
        leading: IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () => {print("Menu is pressed!")},
        ),
        // Actions for placing icons to the right side
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => {print("User is logging out!")},
          )
        ],
      ),

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          // Aligning all items to the center (incase of vertical or horizontal orientation)
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: <Widget>[
            /***************** Button ******************/
            // Inserting the Create Event list button
            ElevatedButton(
              /* Defining the action of the button */
              onPressed: () {
                const snackBar = SnackBar(
                  content:  Text("A new event has been created!"),
                  duration: Duration(seconds: 1),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(120, 40),
                textStyle: const TextStyle(fontSize: 20), // Text size inside the button
              ),
              /* Defining the attributes of the button */
              child: const Row(children: [
                Icon(Icons.add),
                Text("Create a new Event/List"),
              ]),
            ),

            /***************** Profile Widget ******************/
            const ProfileWidget(
              imageUrl: 'assets/images/Ahmed Wael.jpg', // Replace with your image URL
              name: 'Ahmed Wael', // Replace with the user's name
            ),

            /***************** Text ******************/
            Expanded(
              child: FriendsList(), // Expands to fill available space
            ),
            //FriendsList(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
