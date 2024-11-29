import 'package:firebase_auth/firebase_auth.dart';

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
  }) async {
    try {
      // Create a new user with email and password
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the newly created user
      User? user = userCredential.user;

      // If user creation is successful, update the display name
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload(); // Ensure the changes are reflected
        return null; // Null means success
      }
      else {
        return 'Failed to create user: User is null.';
      }
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
