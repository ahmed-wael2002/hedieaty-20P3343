import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/constants/shared_preferences_keys.dart';
import '../../data/repository/auth_repository.dart';
import '../../domain/usecases/login_params.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoggedIn = false;
  bool isSignedUp = false;

  final LoginUsercase loginUsecase = LoginUsercase(AuthRepositoryImpl());
  final RegisterUsecase registerUsecase = RegisterUsecase(AuthRepositoryImpl());

  /// Constructor to initialize necessary variables
  AuthProvider() {
    _initializeAuthProvider();
  }

  /// Helper method to initialize values
  Future<void> _initializeAuthProvider() async {
    var prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool(isLoggedInKey) ?? false;
    notifyListeners();
  }

  /// Check if the user is logged in
  Future<void> checkIsLoggedIn() async {
    var prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool(isLoggedInKey) ?? false;
  }

  /// Logout the user
  Future<void> logout() async {
    var prefs = await SharedPreferences.getInstance();
    isLoggedIn = false;
    prefs.setBool(isLoggedInKey, false);
    notifyListeners();
  }

  /// Login the user
  Future<void> login(String email, String password) async {
    isLoggedIn = await loginUsecase.call(params: LoginParams('', email, password));
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLoggedInKey, isLoggedIn);
    notifyListeners();
  }

  /// Register a new user
  Future<void> register(String name, String email, String password) async {
    isSignedUp = await registerUsecase.call(params: LoginParams(name, email, password));
    notifyListeners();
  }
}
