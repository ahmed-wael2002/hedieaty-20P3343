import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../Logic/event.dart';
import '../Pages/EventsPage.dart';

class EventsList extends StatefulWidget {
  final List<Event>? events;
  const EventsList(this.events, {super.key});

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  late List<Event> _events;
  late List<Event> _filteredEvents;
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
        return event.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              'assets/images/empty.png',
              width: 200,
              height: 200,
            ),
          )
              : ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: _filteredEvents.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Eventspage(event: _filteredEvents[index]),
                    ),
                  );
                },
                title: Text(_filteredEvents[index].name),
                subtitle: Text(_filteredEvents[index].numberOfGifts == 0
                    ? 'No gifts'
                    : '${_filteredEvents[index].numberOfGifts} gifts'),
                leading: _filteredEvents[index].type,
                trailing: IconButton(
                  icon: const Icon(LineAwesomeIcons.trash, color: Colors.red),
                  onPressed: () => setState(() {
                    _events.removeAt(index);
                    filterEvents();
                  }),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
          ),
        ),
      ],
    );
  }
}
