import 'package:flutter/material.dart';
import '../features/homepage/domain/entity/user.dart';
import '../Utils/friends_list_view.dart';
import '../utils/header.dart';
import '../features/homepage/presentation/widgets/profile_widget.dart';

class Friendpage extends StatelessWidget {
  final UserEntity friend;
  const Friendpage(this.friend, {super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const Header(),
      body: Column(
        children: [
          const ProfileWidget(),
          Expanded(child:FriendsList(friend.friendsList),)
        ],
      ),

    );
  }
}
