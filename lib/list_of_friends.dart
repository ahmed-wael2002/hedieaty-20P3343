import 'package:flutter/material.dart';

class Friend{
  String __name = 'Ahmed Wael';
  int __numberOfUpcomingEvents = 0;
  String __image_url = 'assets/images/default.jpg';

  Friend(String name, number, url){
    __name = name;
    __numberOfUpcomingEvents = number;
    __image_url = url;
  }

  String get _image_url => __image_url;

  set _image_url(String value) {
    __image_url = value;
  }

  int get _numberOfUpcomingEvents => __numberOfUpcomingEvents;

  set _numberOfUpcomingEvents(int value) {
    __numberOfUpcomingEvents = value;
  }

  String get _name => __name;

  set _name(String value) {
    __name = value;
  }
}

class FriendsList extends StatelessWidget{
  List<Friend>friends = [
    Friend('Ahmed Wael', 1, 'assets/images/Ahmed Wael.jpg'),
    Friend('Mohamed Soheil', 2, 'assets/images/default.jpg'),
    Friend('Ahmed Bakr', 3, 'assets/images/default.jpg'),
    Friend('Ahmed Nabieh', 4, 'assets/images/default.jpg'),
    Friend('Mohamed Ouda', 5, 'assets/images/default.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: friends.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(friends[index]._name + '\n' + friends[index]._numberOfUpcomingEvents.toString()),
          tileColor: Colors.purple[100],
          onTap: (){},
          leading:    CircleAvatar(
            radius: 40, // Size of the circular image
            backgroundImage: AssetImage(friends[index]._image_url), // The image from assets
          ),
          trailing: const Icon(Icons.menu),
        );
      }, separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
    );
  }
}