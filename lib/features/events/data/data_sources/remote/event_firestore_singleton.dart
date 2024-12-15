import '../../../../../common/remote/firestore_singleton.dart';
import 'package:flutter/material.dart';

class EventFirestore {
  // Private constructor
  EventFirestore._privateConstructor();
  // Single instance of the class
  static final EventFirestore instance = EventFirestore._privateConstructor();
  final FirestoreService _firestore = FirestoreService.instance;
  final String _collectionId = 'events';

  Future<void> addEvent(String eventId, Map<String, dynamic> data) async{
    try {
      await _firestore.addDocument(documentId: eventId, collectionPath: _collectionId, data: data);
      debugPrint('Event added');
    } catch (e) {
      debugPrint('Error adding event: $e');
      rethrow;
    }
  }

  // Example of fetching a document by ID
  Future<Map<String, dynamic>?> getEventById(String eventId) async {
    debugPrint('Trying to get the event: $eventId');
    try {
      return await _firestore.fetchDocument(
        collectionPath: _collectionId,
        documentId: eventId,
      );
    } catch (e) {
      debugPrint('Error fetching event: $e');
      rethrow;
    }
  }

  // Example of updating a document
  Future<void> updateEvent(String eventId, Map<String, dynamic> data) async {
    try{
      await _firestore.updateDocument(
        collectionPath: _collectionId,
        documentId: eventId,
        data: data,
      );
      debugPrint('Event updated');
    } catch (e) {
      debugPrint('Error updating event: $e');
      rethrow;
    }
  }

  Future<void> deleteEvent(String eventId) async{
    try {
      await _firestore.deleteDocument(
        collectionPath: _collectionId,
        documentId: eventId,
      );
      debugPrint('Event deleted');
    } catch (e) {
      debugPrint('Error deleting event: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAllEvents(String userId) async {
    try {
      return await _firestore.fetchDocumentsByQuery(
        collectionPath: _collectionId,
        field: 'userId',
        value: userId,
        operator: QueryOperator.isEqualTo,
      );
    } catch (e) {
      debugPrint('Error fetching all events: $e');
      rethrow;
    }
  }

  Future<void> addGiftToEvent(String eventId, String giftId) async {
    try {
      // Fetch the event document
      var event = await getEventById(eventId);
      if (event == null) {
        throw Exception('Event not found');
      }

      // Add the event to the event's event list
      List<dynamic> gifts = event['gifts'];
      gifts.add(giftId);

      // Update the event document
      await updateEvent(eventId, {'gifts': gifts});
    } catch (e) {
      debugPrint('Error adding gift to event: $e');
      rethrow;
    }
  }
}
