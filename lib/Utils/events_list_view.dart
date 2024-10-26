import 'package:flutter/material.dart';
import '../Logic/event.dart';
import '../Pages/EventsPage.dart';

class EventsList extends StatelessWidget {
  final List<Event>? events;

  const EventsList(this.events, {super.key});

  @override
  Widget build(BuildContext context) {
    return events == null || events!.isEmpty
        ? Center( child: Image.asset('assets/images/empty.png', width: 300, height: 300,),)
        : ListView.separated(
      itemCount: events!.length,
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
            title: Text(events![index].name),
            subtitle: Text(events![index].numberOfGifts == 0? 'No gifts' : '${events![index].numberOfGifts} of gifts'),
            leading: events![index].type,
            trailing: const Icon(Icons.arrow_forward),
          );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
    );
  }
}
