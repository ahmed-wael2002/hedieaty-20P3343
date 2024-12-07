import '../../../../../common/remote/firestore_singleton.dart';

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
      print('User added');
      return true;
    } catch (e) {
      print('Error adding user: $e');
      return false;
    }
  }

  // Example of fetching a document by ID
  Future<Map<String, dynamic>?> getUserById(String userId) async {
    print('Trying to get the user: $userId');
    try {
      return await _firestore.fetchDocument(
        collectionPath: _collectionId,
        documentId: userId,
      );
    } catch (e) {
      print('Error fetching user: $e');
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
      print('User updated');
      return true;
    } catch (e) {
      print('Error updating user: $e');
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
      print('User deleted');
      return true;
    } catch (e) {
      print('Error deleting user: $e');
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
      print('Error fetching all users: $e');
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
      print('Error fetching user by phone number: $e');
      rethrow;
    }
  }

}
