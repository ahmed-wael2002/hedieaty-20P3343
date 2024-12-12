import 'package:flutter/material.dart';
import 'package:lecture_code/common/constants/text_constants.dart';
import 'package:lecture_code/features/users/domain/entity/user.dart';

import '../../../../common/constants/images_paths.dart';

class FriendPage extends StatelessWidget {
  final UserEntity friend;
  const FriendPage({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(friend.name ?? unknownString),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        height: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Friend Image
              Hero(
                tag: '${friend.uid}',
                child: CircleAvatar(
                  radius: 55,
                  // Todo: Change to dynamic image
                  backgroundImage: AssetImage(defaultImagePath),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                friend.email ?? unknownString,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              Text(
                friend.phoneNumber ?? unknownString,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              // EventsList(friend.eventsList),
            ],
          ),
      ),
    );
  }
}
