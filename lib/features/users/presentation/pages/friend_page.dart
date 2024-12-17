import 'package:flutter/material.dart';
import 'package:lecture_code/common/constants/text_constants.dart';
import 'package:lecture_code/features/events/presentation/widgets/events_wrapper.dart';
// import 'package:lecture_code/features/events/presentation/widgets/events_wrapper.dart';
// import 'package:lecture_code/features/events/presentation/widgets/friend_events_wrapper.dart';
import 'package:lecture_code/features/users/domain/entity/user.dart';
import 'package:lecture_code/features/users/presentation/state_management/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../../common/constants/images_paths.dart';
import '../../../events/presentation/state_management/event_provider.dart';
// import '../../../events/presentation/widgets/events_list_view.dart';
// import '../state_management/user_provider.dart';

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
                  backgroundImage: AssetImage(defaultProfileImagePath),
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
              // const EventsWrapper()
              MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (_) => EventProvider()),
                  ChangeNotifierProvider(create: (_) => UserProvider()),
                  // Add other providers here if needed
                ],
                child: Expanded(child: EventsWrapper(friendId: friend.uid, isRemote: true,))
                // child: Expanded(child:FriendEventsWrapper(friendId: friend.uid!)),
              )
            ],
          ),
      ),
    );
  }
}
