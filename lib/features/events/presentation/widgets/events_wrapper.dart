import 'package:flutter/material.dart';
import 'package:lecture_code/features/events/domain/entity/event.dart';
import 'package:lecture_code/features/events/presentation/widgets/events_list_view.dart';
import 'package:provider/provider.dart';

import '../../../users/presentation/state_management/user_provider.dart';
import '../state_management/event_provider.dart';

class EventsWrapper extends StatelessWidget {
  const EventsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final currentUser = userProvider.user;
    final eventProvider = Provider.of<EventProvider>(context, listen: true);

    return FutureBuilder(
        future: eventProvider.getAllEvents(currentUser!.uid),
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
          }
          else{
            eventsList = snapshot.data!;
          }

          return EventsList(eventsList);
        },
    );
  }
}

