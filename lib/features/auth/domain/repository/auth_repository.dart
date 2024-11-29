import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> signIn(String email, String password);
  Future<String?> register(String name, String email, String password, String phoneNumber);
  Future<void> signOut();
  Future<void> sendPasswordReset(String email);
  User? getCurrentUser();
  bool isUserLoggedIn();
}
