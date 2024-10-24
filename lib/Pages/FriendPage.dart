import 'package:flutter/material.dart';
import '../Logic/user.dart';
import '../utils/profile_widget.dart';
import '../Utils/friends_list_view.dart';
import '../utils/header.dart';

class Friendpage extends StatelessWidget {
  final User friend;
  Friendpage(this.friend);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Header(),
      body: Column(
        children: [
          ProfileWidget(imageUrl: friend.imageUrl, name: friend.name),
          FriendsList(friend.friendsList),
        ],
      ),

    );
  }
}
