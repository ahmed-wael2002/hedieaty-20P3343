import '../entity/event.dart';

abstract class EventRepository {
  Future<EventEntity?> fetchEvent(String eventId);
  Future<void> createEvent(EventEntity event);
  Future<void> updateEvent(EventEntity event);
  Future<void> deleteEvent(EventEntity event);
  Future<List<EventEntity>?> getAllEvents(String eventId);
}