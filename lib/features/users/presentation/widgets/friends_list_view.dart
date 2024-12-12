import 'package:flutter/material.dart';
import 'package:lecture_code/features/users/presentation/widgets/friend_list_tile.dart';
import 'package:provider/provider.dart';
import '../../domain/entity/user.dart';
import '../state_management/user_provider.dart';

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
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    userProvider.user?.friendsList = _friends;

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
              return FriendListTile(friend: _filteredFriends[index], onRemove: (){
                userProvider.removeFriend(_filteredFriends[index]);
                // _filteredFriends.removeAt(index);
              });
            },
            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
          ),
        ),
      ],
    );
  }
}
