import 'package:flutter/cupertino.dart';
import 'package:lecture_code/features/auth/data/data_sources/fireauth_singleton.dart';
import 'package:lecture_code/features/auth/domain/usecases/register_usecase.dart';
import 'package:lecture_code/features/auth/domain/usecases/signin_usecase.dart';
import 'package:lecture_code/features/auth/domain/usecases/signout_usecase.dart';
import 'package:lecture_code/features/auth/domain/usecases/usecase_parameters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/constants/shared_preferences_keys.dart';
import '../../data/repository/auth_repository.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool isLoggedIn = false;
  bool isSignedUp = false;
  String uid = '';

  final signInUsecase = SignInUseCase(FirebaseAuthRepository(FirebaseAuthSingleton.instance));
  final registerUsecase = RegisterUseCase(FirebaseAuthRepository(FirebaseAuthSingleton.instance));
  final signOutUsecase = SignOutUseCase(FirebaseAuthRepository(FirebaseAuthSingleton.instance));

  /// Constructor to initialize necessary variables
  AuthenticationProvider() {
    _initializeAuthProvider();
  }

  /// Helper method to initialize values
  Future<void> _initializeAuthProvider() async {
    var prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool(isLoggedInKey) ?? false;
    uid = prefs.getString(userIdKey) ?? '';
    notifyListeners();
  }

  /// Logout the user
  Future<void> logout() async {
    signOutUsecase.call();
    isLoggedIn = false;
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLoggedInKey, false);
    notifyListeners();
  }

  /// Login the user
  Future<void> login(String email, String password) async {
    uid = await signInUsecase.call(params: SignInParams(email: email, password: password));
    isLoggedIn = uid != '';
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLoggedInKey, isLoggedIn);
    prefs.setString(userIdKey, uid);
    notifyListeners();
  }

  /// Register a new user
  Future<void> register(String name, String email, String password, String phoneNumber) async {
    isSignedUp = await registerUsecase.call(params: RegisterParams(name: name, email: email, password: password, phoneNumber: phoneNumber)) == null;
    notifyListeners();
  }
}
