import 'package:flutter/material.dart';
import 'package:lecture_code/features/events/presentation/state_management/event_provider.dart';
import 'package:provider/provider.dart';
import '../../../../common/constants/images_paths.dart';
import '../../../users/presentation/state_management/user_provider.dart';
import '../../domain/entity/event.dart';
import 'event_list_tile.dart';

class EventsList extends StatefulWidget {
  final List<EventEntity>? events;
  const EventsList(this.events, {super.key});

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  late List<EventEntity> _events;
  late List<EventEntity> _filteredEvents;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _events = widget.events ?? [];
    _filteredEvents = _events;
    _searchController  = TextEditingController();
    _searchController.addListener(() {
      filterEvents();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void filterEvents() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredEvents = _events.where((event) {
        return event.title!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final eventProvider = Provider.of<EventProvider>(context, listen: true);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search for an event...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
          ),
        ),
        Expanded(
          child: _filteredEvents.isEmpty
              ? Center(
            child: Image.asset(
              emptyImagePath,
              width: 200,
              height: 200,
            ),
          )
              : ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: _filteredEvents.length,
            itemBuilder: (BuildContext context, int index) {
              return EventListTile(
                event: _filteredEvents[index],
                onRemove: () {
                  setState(() {
                    userProvider.removeEvent(_events[index]);
                    eventProvider.deleteEvent(event: _events[index], context: context);
                    _events.removeAt(index);
                    filterEvents();
                  });
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
          ),
        ),
      ],
    );
  }
}
