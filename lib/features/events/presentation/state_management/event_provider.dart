import 'package:flutter/material.dart';
import 'package:lecture_code/features/events/data/repository/local/event_local_repository.dart';
import 'package:lecture_code/features/events/data/repository/remote/event_remote_repository.dart';

import '../../../gifts/domain/entity/gift.dart';
import '../../domain/entity/event.dart';
import '../../domain/usecases/add_gift_usecase.dart';
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
  var addGiftUsecase = AddGiftUsecase(FirestoreRepositoryImpl());

  var createEventLocalUsecase = CreateEventUsecase(SqfliteRepositoryImpl());
  var deleteEventLocalUsecase = DeleteEventUsecase(SqfliteRepositoryImpl());
  var fetchEventLocalUsecase = FetchEventUsecase(SqfliteRepositoryImpl());
  var updateEventLocalUsecase = UpdateEventUsecase(SqfliteRepositoryImpl());
  var getAllEventsLocalUsecase = GetAllEventsUsecase(SqfliteRepositoryImpl());
  var addGiftLocalUsecase = AddGiftUsecase(SqfliteRepositoryImpl());

  void createEvent({required EventEntity event, required context, required bool isRemote}) async {
    bool success = false;
    if(isRemote){
      success = await createEventUsecase.call(params: event);
    }
    else{
      success = await createEventLocalUsecase.call(params: event);
    }

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Event created successfully'), backgroundColor: Colors.green,));
      notifyListeners(); // Notify listeners after creating an event
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not create event'), backgroundColor: Colors.red,));
    }
  }

  void deleteEvent({required EventEntity event, required bool isRemote,required context}) async {
    bool success = false;
    if(isRemote){
      success = await deleteEventUsecase.call(params: event);
    }
    else{
      success = await deleteEventLocalUsecase.call(params: event);
    }

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Event deleted successfully'), backgroundColor: Colors.green,));
      notifyListeners(); // Notify listeners after deleting an event
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not delete event'), backgroundColor: Colors.red,));
    }
  }

  void updateEvent({required EventEntity event, required bool isRemote, required context}) async {
    bool success = false;
    if(isRemote){
      success = await updateEventUsecase.call(params: event);
    }
    else{
      success = await updateEventLocalUsecase.call(params: event);
    }
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Event updated successfully'), backgroundColor: Colors.green,));
      notifyListeners(); // Notify listeners after updating an event
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not update event'), backgroundColor: Colors.red,));
    }
  }

  void fetchEvent({required String? uid, required isRemote}) async{
    await fetchEventUsecase.call(params: uid);
    notifyListeners();
  }


  Future<List<EventEntity>?> getAllEvents(String? uid, bool isRemote) async{
    if(isRemote){
      return await getAllEventsUsecase.call(params: uid);
    }else{
      return await getAllEventsLocalUsecase.call(params: uid);
    }
  }

  Future<bool?> addGift({required EventEntity event, required GiftEntity gift, required BuildContext context}) async{
    if(await addGiftUsecase.call(params: AddGiftParams(event: event, gift: gift))){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gift added successfully'), backgroundColor: Colors.green,));
      return true;
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not add gift'), backgroundColor: Colors.red,));
      return false;
    }
  }
}