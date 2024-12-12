import 'package:flutter/material.dart';
import 'package:lecture_code/features/events/data/repository/event_repository.dart';

import '../../domain/entity/event.dart';
import '../../domain/usecases/create_event_usecase.dart';
import '../../domain/usecases/delete_event_usecase.dart';
import '../../domain/usecases/fetch_event_usecase.dart';
import '../../domain/usecases/get_all_events_usecase.dart';
import '../../domain/usecases/update_event_usecase.dart';

class EventProvider extends ChangeNotifier{
  var createEventUsecase = CreateEventUsecase(FirestoreRepositoryImpl());
  var deleteEventUsecase = DeleteEventUsecase(FirestoreRepositoryImpl());
  var fetchEventUsecase = FetchEventUsecase(FirestoreRepositoryImpl());
  var updateEventUsecase = UpdateEventUsecase(FirestoreRepositoryImpl());
  var getAllEventsUsecase = GetAllEventsUsecase(FirestoreRepositoryImpl());

  void createEvent({required EventEntity event, required context}) async{
    if(await createEventUsecase.call(params: event)){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Event created successfully'), backgroundColor: Colors.green,));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not create event'), backgroundColor: Colors.red,));
    }
    notifyListeners();
  }

  void deleteEvent({required EventEntity event, required context}) async{
    if(await deleteEventUsecase.call(params: event)){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Event deleted successfully'), backgroundColor: Colors.green,));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not delete event'), backgroundColor: Colors.red,));
    }
    notifyListeners();
  }

  Future<List<EventEntity>?> getAllEvents(String? uid) async{
    return await getAllEventsUsecase.call(params: uid);
  }
}