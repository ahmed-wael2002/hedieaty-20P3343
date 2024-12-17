import 'package:flutter/material.dart';
import 'package:lecture_code/features/events/domain/entity/event.dart';
import 'package:lecture_code/features/events/presentation/widgets/events_list_view.dart';
import 'package:provider/provider.dart';

import '../../../users/presentation/state_management/user_provider.dart';
import '../state_management/event_provider.dart';

class EventsWrapper extends StatelessWidget {
  final String? friendId;
  final bool isRemote;
  const EventsWrapper({this.friendId, super.key, required this.isRemote});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final currentUser = userProvider.user;
        return Consumer<EventProvider>(
          builder: (context, eventProvider, child) {
            return FutureBuilder(
              future: eventProvider.getAllEvents(friendId ?? currentUser!.uid, isRemote),
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

                List<EventEntity> eventsList;
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  eventsList = [];
                } else {
                  eventsList = snapshot.data!;
                }
                return EventsList(events: eventsList, isEditable: (friendId == null), isRemote: isRemote,);
              },
            );
          },
        );
      },
    );
  }
}
