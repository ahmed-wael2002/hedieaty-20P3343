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

  @override
  void initState() {
    super.initState();
    _events = widget.events ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return widget.events == null || widget.events!.isEmpty
        ? Center( child: Image.asset('assets/images/empty.png', width: 300, height: 300,),)
        : ListView.separated(
      padding: const EdgeInsets.all(16.0), // Padding on all sides
      itemCount: widget.events!.length,
      itemBuilder: (BuildContext context, int index) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            // tileColor: Colors.purple[100],
            onTap:(){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Eventspage(),
                ),
              );
            },
            title: Text(widget.events![index].name),
            subtitle: Text(widget.events![index].numberOfGifts == 0? 'No gifts' : '${widget.events![index].numberOfGifts} of gifts'),
            leading: widget.events![index].type,
            trailing: IconButton(
              icon: const Icon(LineAwesomeIcons.trash, color: Colors.red),
              onPressed: ()=>setState(() {
                _events.removeAt(index);
              }),
            ),
          );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
    );
  }
}
