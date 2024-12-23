import 'package:firebase_auth/firebase_auth.dart';
import 'package:lecture_code/features/auth/data/data_sources/fireauth_singleton.dart';
import 'package:lecture_code/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter/material.dart';


class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuthSingleton _authSingleton;

  FirebaseAuthRepository(this._authSingleton);

  @override
  Future<User?> signIn(String email, String password) async {
    try {
      return await _authSingleton.signInWithEmailAndPassword(email, password);
    } catch (e) {
      debugPrint('Error in signIn: $e');
      rethrow;
    }
  }

  @override
  Future<String?> register(String name, String email, String password, String phoneNumber) async {
    try {
      return await _authSingleton.registerNewUser(
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );
    } catch (e) {
      debugPrint('Error in register: $e');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _authSingleton.signOut();
    } catch (e) {
      debugPrint('Error in signOut: $e');
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    try {
      await _authSingleton.sendPasswordResetEmail(email);
    } catch (e) {
      debugPrint('Error in sendPasswordReset: $e');
      rethrow;
    }
  }

  @override
  User? getCurrentUser() {
    return _authSingleton.currentUser;
  }

  @override
  bool isUserLoggedIn() {
    return _authSingleton.isUserLoggedIn;
  }
}
