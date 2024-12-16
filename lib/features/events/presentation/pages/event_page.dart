import 'package:flutter/material.dart';
import 'package:lecture_code/features/events/presentation/widgets/event_modal_sheet.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/constants/images_paths.dart';
import '../../../gifts/domain/entity/gift.dart';
import '../../../gifts/presentation/state_management/gift_provider.dart';
import '../../../gifts/presentation/widgets/gift_edit_sheet.dart';
import '../../../gifts/presentation/widgets/gift_list_view.dart';
import '../../domain/entity/event.dart';
import '../state_management/event_provider.dart';

class EventPage extends StatefulWidget {
  final bool isEditable;
  final EventEntity event;
  const EventPage({super.key, required this.event, required this.isEditable});

  @override
  EventPageState createState() => EventPageState();
}

class EventPageState extends State<EventPage> {
  late EventEntity event;

  @override
  void initState() {
    super.initState();
    event = widget.event;
  }

  @override
  Widget build(BuildContext context) {
    final giftsProvider = Provider.of<GiftProvider>(context, listen: true);
    final eventProvider = Provider.of<EventProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title ?? 'Unknown'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Hero(
            tag: '${event.id}',
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(defaultEventImagePath),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            event.description ?? 'No description',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Event Date: ${event.date?.day}/${event.date?.month}/${event.date?.year}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: FutureBuilder(
                future: giftsProvider.getGifts(event.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('An error occurred'));
                  }
                  if (snapshot.hasData) {
                    final gifts = snapshot.data as List<GiftEntity>;
                    return GiftsListView(gifts: gifts, isEditable: widget.isEditable,);
                  }
                  return const Center(child: Text('No gifts found'));
                }),
          ),
        ],
      ),
      floatingActionButton: widget.isEditable ? Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'edit_event_${event.id}_${UniqueKey()}',
            backgroundColor: Theme.of(context).colorScheme.primary,
            splashColor: Theme.of(context).colorScheme.onPrimaryContainer,
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => EventModalSheet(
                  event: event,
                  onSave: (updatedEvent) {
                    setState(() {
                      event = updatedEvent;
                    });
                    eventProvider.updateEvent(event: updatedEvent, context: context);
                  },
                  isEditing: widget.isEditable,
                ),
              );
            },
            child: Icon(Icons.edit, color: Theme.of(context).colorScheme.surface),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'add_gift_${event.id}_${UniqueKey()}',
            backgroundColor: Theme.of(context).colorScheme.primary,
            splashColor: Theme.of(context).colorScheme.onPrimaryContainer,
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => GiftEditSheet(
                  isEditing: false,
                  gift: GiftEntity(
                    id: const Uuid().v4(),
                    name: '',
                    description: '',
                    category: '',
                    price: '',
                    isPledged: false,
                    eventId: event.id!,
                    userId: event.userId!,
                  ),
                  onSave: (gift) {
                    giftsProvider.createGift(gift);
                  },
                ),
              );
            },
            child: Icon(Icons.add, color: Theme.of(context).colorScheme.surface),
          ),
        ],
      ) : null,
    );
  }
}