import 'package:lecture_code/features/events/data/data_sources/remote/event_firestore_singleton.dart';
import 'package:lecture_code/features/events/domain/entity/event.dart';
import 'package:lecture_code/features/events/domain/repository/event_repository.dart';
import 'package:lecture_code/features/gifts/domain/entity/gift.dart';
// import 'package:lecture_code/features/gifts/data/repository/remote/gift_repository.dart';
// import 'package:lecture_code/features/gifts/domain/usecases/get_gifts_usecase.dart';

import '../../model/event.dart';

class FirestoreRepositoryImpl implements EventRepository{
  final _firestore = EventFirestore.instance;

  @override
  Future<void> createEvent(EventEntity event) async{
    try{
      await _firestore.addEvent(event.id!, EventModel.fromEntity(event).toMap());
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<void> deleteEvent(EventEntity event) {
    try{
      return _firestore.deleteEvent(event.id!);
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<EventEntity?> fetchEvent(String eventId) async {
    try {
      Map<String, dynamic>? result = await _firestore.getEventById(eventId);
      if (result != null) {
        var eventModel = EventModel.fromMap(result);
        var eventEntity = EventEntity.fromModel(eventModel);

        // Fetch gifts associated with the event
        // List<GiftEntity>? gifts = await GetGiftsUsecase(GiftRepositoryFirestoreImpl()).call(params: eventId);
        // eventEntity.giftsList = gifts??[];

        return eventEntity;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  @override
  Future<List<EventEntity>?> getAllEvents(String userId) {
    try{
      return _firestore.getAllEvents(userId).then((events) => events.map((event) => EventEntity.fromModel(EventModel.fromMap(event))).toList());
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<void> updateEvent(EventEntity event) {
    try{
      return _firestore.updateEvent(event.id!, EventModel.fromEntity(event).toMap());
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<void> addGift(EventEntity event, GiftEntity gift) {
    try{
      return _firestore.addGiftToEvent(event.id!, gift.id);
    }
    catch(e){
      rethrow;
    }
  }

}