import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../Logic/user.dart';
import '../Pages/FriendPage.dart';

class FriendsList extends StatefulWidget {
  final List<User>? friends;
  FriendsList(this.friends, {super.key});

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  late List<User> _friends;

  @override
  void initState() {
    super.initState();
    _friends = widget.friends ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return _friends.isEmpty
        ? Center(
      child: Image.asset(
        'assets/images/empty.png',
        width: 200,
        height: 200,
      ),
    )
        : ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: _friends.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Friendpage(_friends[index]),
              ),
            );
          },
          title: Text(_friends[index].name),
          subtitle: Text(_friends[index].upcomingEvents == 0
              ? 'No Upcoming Events'
              : '${_friends[index].upcomingEvents} Upcoming Events'),
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(_friends[index].imageUrl),
          ),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                _friends.removeAt(index);
              });
            },
            icon: const Icon(LineAwesomeIcons.trash, color: Colors.red),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
    );
  }
}
