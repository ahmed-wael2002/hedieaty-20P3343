import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreDataSource {
  // Private constructor
  FirestoreDataSource._privateConstructor();

  // The single instance
  static final FirestoreDataSource _instance = FirestoreDataSource._privateConstructor();

  // Getter for the instance
  static FirestoreDataSource get instance => _instance;

  // FirebaseFirestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Initialize Firestore (typically done once in the main app entry)
  Future<void> initialize() async {
    await Firebase.initializeApp();  // Ensure Firebase is initialized
  }

  // Example of adding data to a collection
  Future<void> addUser(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userId).set(data);
      print('User added');
    } catch (e) {
      print('Error adding user: $e');
      rethrow;
    }
  }

  // Example of fetching a document by ID
  Future<Map<String, dynamic>?> getUser(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      if(doc.exists){
        return doc.data() as Map<String, dynamic>;
      }
      return null;
    }
    catch (e) {
      print('Error fetching user: $e');
      rethrow;
    }
  }

  // Example of updating a document
  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userId).update(data);
      print('User updated');
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  // Example of deleting a document
  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
      print('User deleted');
    } catch (e) {
      print('Error deleting user: $e');
      rethrow;
    }
  }

  // Example of querying a collection
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();
      List<Map<String, dynamic>> users = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      return users;
    } catch (e) {
      print('Error fetching all users: $e');
      rethrow;
    }
  }
}
