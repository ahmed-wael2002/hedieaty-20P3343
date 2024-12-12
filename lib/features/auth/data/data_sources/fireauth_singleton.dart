import 'package:firebase_auth/firebase_auth.dart';
import 'package:lecture_code/features/users/data/data_sources/remote/firestore_singleton.dart';
import 'package:lecture_code/features/users/data/model/user.dart';

class FirebaseAuthSingleton {
  // Private constructor
  FirebaseAuthSingleton._privateConstructor();

  // The single instance
  static final FirebaseAuthSingleton _instance = FirebaseAuthSingleton._privateConstructor();

  // Getter for the instance
  static FirebaseAuthSingleton get instance => _instance;

  // FirebaseAuth instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Method to get the current user
  User? get currentUser => _firebaseAuth.currentUser;

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    }
    catch (e) {
      rethrow;
    }
  }

  // Register with email and password
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    }
    catch (e) {
      rethrow;
    }
  }

  Future<String?> registerNewUser({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      // Create a new user with email and password
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the newly created user
      User? user = userCredential.user;

      await UserFirestore.instance.addUser(user!.uid, UserModel(
          uid: user.uid,
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          friendsIds: [],
          eventsIds: []
        ).toMap()
      );

      // If user creation is successful, update the display name
      await user.updateDisplayName(name);
      await user.reload(); // Ensure the changes are reflected
      await signOut();
      return null; // Null means success
        } catch (e) {
      // Return the error message
      return 'Failed to register: ${e.toString()}';
    }
  }


  // Sign out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    }
    catch (e) {
      rethrow;
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    }
    catch (e) {
      rethrow;
    }
  }

  // Check if a user is logged in
  bool get isUserLoggedIn => currentUser != null;
}
