import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Ahmed Wael"),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(onPressed: () { print('Take Alert'); }, icon: Icon(Icons.add_alert))
        ],
      ),
      body: Center(
        child: Image(image: AssetImage('images/heart.png'),),
      ),
    )
  ));
}
