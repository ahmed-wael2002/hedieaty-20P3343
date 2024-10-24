import 'package:flutter/material.dart';
import '../Logic/user.dart';
import '../Pages/FriendPage.dart';

class FriendsList extends StatelessWidget {
  final List<User>? friends;

  FriendsList(this.friends, {super.key});

  @override
  Widget build(BuildContext context) {
    return friends == null || friends!.isEmpty
        ? Center(
          child: Column(children: [
            const Text('You have no friends :(', style: TextStyle(fontWeight:FontWeight.bold, fontSize: 25),),
            Image.asset('assets/images/no_friends.jpg', width: 300, height: 300,),
          ],
          )
        )
        : ListView.separated(
      itemCount: friends!.length,
      itemBuilder: (BuildContext context, int index) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            tileColor: Colors.purple[100],
            onTap:(){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Friendpage(friends![index]),
                ),
              );
            },
            title: Text(friends![index].name),
            subtitle: Text(friends![index].upcomingEvents == 0? 'No Upcoming Events' : '${friends![index].upcomingEvents} Upcoming Events'),
            leading: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(friends![index].imageUrl),
            ),
            trailing: const Icon(Icons.arrow_forward),
          );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
    );
  }
}
