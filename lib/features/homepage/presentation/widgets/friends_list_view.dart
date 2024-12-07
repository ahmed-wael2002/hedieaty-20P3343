import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../domain/entity/user.dart';
import '../../../../Pages/friends_page.dart';

class FriendsList extends StatefulWidget {
  final List<UserEntity>? friends;
  const FriendsList(this.friends, {super.key});

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  late List<UserEntity> _friends;
  late List<UserEntity> _filteredFriends;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _friends = widget.friends ?? [];
    _filteredFriends = _friends;
    _searchController = TextEditingController();
    _searchController.addListener(() {
      filterFriends();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void filterFriends() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredFriends = _friends.where((friend) {
        return friend.name!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search for a friend...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
          ),
        ),
        Expanded(
          child: _filteredFriends.isEmpty
              ? Center(
            child: Image.asset(
              'assets/images/empty.png',
              width: 200,
              height: 200,
            ),
          )
              : ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: _filteredFriends.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Friendpage(_filteredFriends[index]),
                    ),
                  );
                },
                title: Text(_filteredFriends[index].name!),
                subtitle: Text(_filteredFriends[index].eventsList.isEmpty
                    ? 'No Upcoming Events'
                    : '${_filteredFriends[index].eventsList.length} Upcoming Events'),
                leading: const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/Ahmed Wael.jpg'),
                ),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      _friends.removeAt(index);
                      filterFriends();
                    });
                  },
                  icon: const Icon(LineAwesomeIcons.trash, color: Colors.red),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
          ),
        ),
      ],
    );
  }
}
