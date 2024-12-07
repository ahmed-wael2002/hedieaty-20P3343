import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Private constructor
  FirestoreService._privateConstructor();

  // Single instance
  static final FirestoreService instance = FirestoreService._privateConstructor();

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Method to fetch all documents in a collection
  Future<List<Map<String, dynamic>>> fetchCollection({
    required String collectionPath,
  }) async {
    try {
      final querySnapshot = await _firestore.collection(collectionPath).get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Method to fetch a single document by ID
  Future<Map<String, dynamic>?> fetchDocument({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      final docSnapshot = await _firestore.collection(collectionPath).doc(documentId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data();
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  /// Method to add a document to a collection
  Future<void> addDocument({
    required String collectionPath,
    required String documentId, // Custom ID for the document
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).set(data);
      print('Document added with ID: $documentId');
    } catch (e) {
      print('Error adding document to $collectionPath with ID $documentId: $e');
      rethrow;
    }
  }

  /// Method to update a document by ID
  Future<void> updateDocument({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).update(data);
    } catch (e) {
      rethrow;
    }
  }

  /// Method to delete a document by ID
  Future<void> deleteDocument({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).delete();
    } catch (e) {
      rethrow;
    }
  }

  /// Method to get a document based on a query using .where()
  Future<List<Map<String, dynamic>>> fetchDocumentsByQuery({
    required String collectionPath,
    required String field,
    required dynamic value,
    required QueryOperator operator, // This will allow the usage of different operators (==, >, <, etc.)
  }) async {
    try {
      Query query;

      // Constructing query based on the operator
      switch (operator) {
        case QueryOperator.isEqualTo:
          query = _firestore.collection(collectionPath).where(field, isEqualTo: value);
          break;
        case QueryOperator.isGreaterThan:
          query = _firestore.collection(collectionPath).where(field, isGreaterThan: value);
          break;
        case QueryOperator.isLessThan:
          query = _firestore.collection(collectionPath).where(field, isLessThan: value);
          break;
        case QueryOperator.isGreaterThanOrEqualTo:
          query = _firestore.collection(collectionPath).where(field, isGreaterThanOrEqualTo: value);
          break;
        case QueryOperator.isLessThanOrEqualTo:
          query = _firestore.collection(collectionPath).where(field, isLessThanOrEqualTo: value);
          break;
        case QueryOperator.arrayContains:
          query = _firestore.collection(collectionPath).where(field, arrayContains: value);
          break;
        case QueryOperator.arrayContainsAny:
          query = _firestore.collection(collectionPath).where(field, arrayContainsAny: value);
          break;
        case QueryOperator.isNull:
          query = _firestore.collection(collectionPath).where(field, isNull: value);
          break;
        default:
          throw Exception('Unsupported query operator');
      }

      // Execute the query
      final querySnapshot = await query.get();

      // Mapping documents data into a list of Map<String, dynamic>
      return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      rethrow;
    }
  }

}

/// Enum for query operators
enum QueryOperator {
  isEqualTo,
  isGreaterThan,
  isLessThan,
  isGreaterThanOrEqualTo,
  isLessThanOrEqualTo,
  arrayContains,
  arrayContainsAny,
  isNull,
}
