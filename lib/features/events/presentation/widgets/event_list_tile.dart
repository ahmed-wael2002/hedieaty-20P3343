import 'package:flutter/material.dart';
import 'package:lecture_code/common/constants/text_constants.dart';
import 'package:lecture_code/features/users/presentation/state_management/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../gifts/presentation/state_management/gift_provider.dart';
import '../../domain/entity/event.dart';
import '../pages/event_page.dart';
import '../state_management/event_provider.dart';

class EventListTile extends StatelessWidget {
  final bool isRemote;
  final bool isEditable;
  final EventEntity event;
  final Function() onRemove;
  const EventListTile({super.key, required this.event, required this.onRemove, required this.isEditable, required this.isRemote});

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
            builder: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => GiftProvider()),
                ChangeNotifierProvider(create: (_) => EventProvider()),
                ChangeNotifierProvider(create: (_) => UserProvider()),
              ],
              child: EventPage(event: event, isEditable: isEditable, isRemote: isRemote,),
            ),
          ),
        );
      },
      title: Text(event.title ?? unknownString),
      subtitle: Text('Event Date: ${event.date?.day}/${event.date?.month}/${event.date?.year}'),
      leading: Hero(
          tag: '${event.id}',
          child:
          const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/images/default_event.png'),
        ),
      ),
      trailing: isEditable ? IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => onRemove(),
      ) : null,
    );
  }
}
