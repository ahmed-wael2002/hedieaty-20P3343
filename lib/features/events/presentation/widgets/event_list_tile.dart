import 'package:flutter/material.dart';
import 'package:lecture_code/common/constants/text_constants.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../domain/entity/event.dart';

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
        // Todo: Navigate to event page
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Eventspage(event: event),
        //   ),
        // );
      },
      title: Text(event.title ?? unknownString),
      // Todo: Add subtitle: number of gifts
      // subtitle: Text( == 0
      //     ? 'No gifts'
      //     : '${_filteredEvents[index].numberOfGifts} gifts'),
      // Todo: Add leading image
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/default_event.png'),
      ),
      trailing: IconButton(
        icon: const Icon(LineAwesomeIcons.trash, color: Colors.red),
        onPressed: () => onRemove(),
      ),
    );
  }
}
