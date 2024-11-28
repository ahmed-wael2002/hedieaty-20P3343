import 'package:flutter/material.dart';
import 'package:lecture_code/common/constants/shared_preferences_keys.dart';
import 'package:lecture_code/features/auth/data/repository/auth_repository.dart';
import 'package:lecture_code/features/auth/domain/usecases/login_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/usecases/login_params.dart';
import '../../domain/usecases/signup_usecase.dart';

class AuthProvider extends ChangeNotifier{
  bool isLoggedIn = false;
  bool isSignedUp = false;

  final LoginUsercase loginUsecase = LoginUsercase(AuthRepositoryImpl());
  final RegisterUsecase registerUsecase = RegisterUsecase(AuthRepositoryImpl());

  Future<void> checkIsLoggedIn() async{
    var prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool(isLoggedInKey) ?? false;
    notifyListeners();
  }

  Future<void> login(String email, String password) async{
    isLoggedIn = await loginUsecase.call(params: LoginParams('', email, password));
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLoggedInKey, isLoggedIn);
    notifyListeners();
  }

  Future<void> register(String name, String email, String password) async{
    isSignedUp = await registerUsecase.call(params: LoginParams(name, email, password));
    notifyListeners();
  }
}
