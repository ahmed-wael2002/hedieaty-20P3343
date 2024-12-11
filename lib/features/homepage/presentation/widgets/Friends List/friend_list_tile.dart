import 'package:flutter/material.dart';
import 'package:lecture_code/common/constants/text_constants.dart';
import 'package:lecture_code/features/homepage/presentation/pages/friend_page.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../../common/constants/images_paths.dart';
import '../../../domain/entity/user.dart';

class FriendListTile extends StatelessWidget {
  final UserEntity friend;
  final Function() onRemove;
  const FriendListTile({super.key, required this.friend, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FriendPage(friend: friend),
          ),
        );
      },
      title: Text(friend.name ?? unknownString),
      subtitle: Text(friend.eventsList.isEmpty
          ? noEventsString
          : '${friend.eventsList.length} Upcoming Events'),
      leading: Hero(
          tag: '${friend.uid}',
          child: CircleAvatar(
        radius: 25,
        // Todo: Change to dynamic image
        backgroundImage: AssetImage(defaultImagePath),
      ),
      ),
      trailing: IconButton(
        onPressed: () {
          onRemove();
        },
        icon: const Icon(LineAwesomeIcons.trash, color: Colors.red),
      ),
    );
  }
}
