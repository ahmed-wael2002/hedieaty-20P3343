import 'package:flutter/material.dart';
import '../Utils/header.dart';

class Eventspage extends StatelessWidget {
  const Eventspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: const Header(),
    body: Column(
      children: [
        IconButton(onPressed: (){ Navigator.pop(context); }, icon: const Icon(Icons.back_hand)),
        const Text('This is the Events Page!'),
      ],
    ),
    );
  }
}
