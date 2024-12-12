import 'package:flutter/material.dart';
import 'package:lecture_code/features/users/domain/entity/user.dart';
import 'package:lecture_code/features/users/presentation/state_management/user_provider.dart';
import 'package:lecture_code/features/users/presentation/widgets/friends_list_view.dart';
import 'package:provider/provider.dart';

class FriendsWrapper extends StatelessWidget {
  const FriendsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final currentUser = userProvider.user;

        // Handle null current user early to avoid calling getAllFriends with null
        if (currentUser == null) {
          return const Center(
            child: Text('No user data available. Please log in.'),
          );
        }

        return FutureBuilder<List<UserEntity>>(
          future: userProvider.getAllFriends(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            List<UserEntity> friendsList;
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // return Center(
              //   child: Image.asset('assets/images/empty.png'),
              // );
              friendsList = [];
            }
            else{
              friendsList = snapshot.data!;
            }

            return FriendsList(friendsList);
          },
        );
      },
    );
  }
}
