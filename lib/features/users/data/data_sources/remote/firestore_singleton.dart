import '../../../../../common/remote/firestore_singleton.dart';
import 'package:flutter/material.dart';

class UserFirestore {
  // Private constructor
  UserFirestore._privateConstructor();

  // Single instance of the class
  static final UserFirestore instance = UserFirestore._privateConstructor();

  final FirestoreService _firestore = FirestoreService.instance;
  final String _collectionId = 'users';

  // Example of adding data to a collection
  Future<bool> addUser(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.addDocument(documentId: userId, collectionPath: _collectionId, data: data);
      debugPrint('User added');
      return true;
    } catch (e) {
      debugPrint('Error adding user: $e');
      return false;
    }
  }

  // Example of fetching a document by ID
  Future<Map<String, dynamic>?> getUserById(String userId) async {
    debugPrint('Trying to get the user: $userId');
    try {
      return await _firestore.fetchDocument(
        collectionPath: _collectionId,
        documentId: userId,
      );
    } catch (e) {
      debugPrint('Error fetching user: $e');
      rethrow;
    }
  }

  // Example of updating a document
  Future<bool> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.updateDocument(
        collectionPath: _collectionId,
        documentId: userId,
        data: data,
      );
      debugPrint('User updated');
      return true;
    } catch (e) {
      debugPrint('Error updating user: $e');
      return false;
    }
  }

  // Example of deleting a document
  Future<bool> deleteUser(String userId) async {
    try {
      await _firestore.deleteDocument(
        collectionPath: _collectionId,
        documentId: userId,
      );
      debugPrint('User deleted');
      return true;
    } catch (e) {
      debugPrint('Error deleting user: $e');
      return false;
    }
  }

  // Example of querying a collection
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      return await _firestore.fetchCollection(
        collectionPath: _collectionId,
      );
    } catch (e) {
      debugPrint('Error fetching all users: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUserByPhoneNumber(String phoneNumber) async {
    try {
      // Fetch documents based on the phone number
      var results = await _firestore.fetchDocumentsByQuery(
        collectionPath: _collectionId,
        field: 'phoneNumber',
        value: phoneNumber,
        operator: QueryOperator.isEqualTo,
      );

      // Check if results are empty and return an empty map if no match is found
      if (results.isEmpty) {
        return {}; // Return empty map when no user is found
      }

      // If results exist, return the first match
      return results.first;
    } catch (e) {
      // Log the error and rethrow it for further handling
      debugPrint('Error fetching user by phone number: $e');
      rethrow;
    }
  }
  
  Future<bool> removeFriendFromUser(String userId, String friendId) async {
    try {
      // Fetch the user document
      var user = await getUserById(userId);
      if (user == null) {
        throw Exception('User not found');
      }

      // Remove the friend from the user's friend list
      List<dynamic> friends = user['friends'];
      friends.remove(friendId);

      // Update the user document
      await updateUser(userId, {'friends': friends});

      return true;
    } catch (e) {
      debugPrint('Error removing friend from user: $e');
      return false;
    }
  }

  Future<void> addEventToUser(String userId, String eventId) async {
    try {
      // Fetch the user document
      var user = await getUserById(userId);
      if (user == null) {
        throw Exception('User not found');
      }

      // Add the event to the user's event list
      List<dynamic> events = user['events'];
      events.add(eventId);

      // Update the user document
      await updateUser(userId, {'events': events});
    } catch (e) {
      debugPrint('Error adding event to user: $e');
      rethrow;
    }
  }

  Future<void> removeEventFromUser(String userId, String eventId) async{
    try{
      // Fetch the user document
      var user = await getUserById(userId);
      if(user == null){
        throw Exception('User not found');
      }

      // Remove the event from the user's event list
      List<dynamic> events = user['events'];
      events.remove(eventId);

      // Update the user document
      await updateUser(userId, {'events': events});
    }
    catch(e){
      debugPrint('Error removing event from user: $e');
      rethrow;
    }
  }
}
