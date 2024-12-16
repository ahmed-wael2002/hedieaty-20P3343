import 'package:flutter/material.dart';
import 'package:lecture_code/common/constants/text_constants.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../gifts/presentation/state_management/gift_provider.dart';
import '../../domain/entity/event.dart';
import '../pages/event_page.dart';
import '../state_management/event_provider.dart';

class EventListTile extends StatelessWidget {
  final EventEntity event;
  final Function() onRemove;
  const EventListTile({super.key, required this.event, required this.onRemove});

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
              ],
              child: EventPage(event: event),
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
      trailing: IconButton(
        icon: const Icon(LineAwesomeIcons.trash, color: Colors.red),
        onPressed: () => onRemove(),
      ),
    );
  }
}
