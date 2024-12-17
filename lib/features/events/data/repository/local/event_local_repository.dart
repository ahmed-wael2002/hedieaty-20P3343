import 'package:lecture_code/features/events/domain/entity/event.dart';
import 'package:lecture_code/features/events/domain/repository/event_repository.dart';
import 'package:lecture_code/features/gifts/domain/entity/gift.dart';
import '../../data_sources/local/events_local_singleton.dart';
import '../../model/event.dart';

class SqfliteRepositoryImpl implements EventRepository{
  final _localEventDatabase = EventLocalDatabase.instance;

  @override
  Future<void> addGift(EventEntity event, GiftEntity gift) {
    // TODO: implement addGift
    throw UnimplementedError();
  }

  @override
  Future<void> createEvent(EventEntity event) async {
    await _localEventDatabase.addEvent(EventModel.fromEntity(event).toMap());
  }

  @override
  Future<void> deleteEvent(EventEntity event) async{
    await _localEventDatabase.deleteEvent(event.id!);
  }

  @override
  Future<EventEntity?> fetchEvent(String eventId) async{
    final eventMap = await _localEventDatabase.getEventById(eventId);
    final EventModel eventModel = EventModel.fromMap(eventMap!);
    return EventEntity.fromModel(eventModel);
  }

  @override
  Future<List<EventEntity>?> getAllEvents(String userId) async{
    final List<Map<String, dynamic>> eventsMap = await _localEventDatabase.getAllEventsByUserId(userId);
    return eventsMap.map((event) => EventEntity.fromModel(EventModel.fromMap(event))).toList();
  }

  @override
  Future<void> updateEvent(EventEntity event) async{
    await _localEventDatabase.updateEvent(event.id!, EventModel.fromEntity(event).toMap());
  }
}