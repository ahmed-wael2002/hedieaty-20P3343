import 'package:flutter/material.dart';
import '../Logic/user.dart';
import '../Utils/friends_list_view.dart';
import '../utils/header.dart';
import '../Utils/profile_widget.dart';

class Friendpage extends StatelessWidget {
  final User friend;
  const Friendpage(this.friend, {super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const Header(),
      body: Column(
        children: [
          ProfileWidget(imageUrl: friend.imageUrl, name: friend.name, email: friend.email),
          Expanded(child:FriendsList(friend.friendsList),)
        ],
      ),

    );
  }
}
