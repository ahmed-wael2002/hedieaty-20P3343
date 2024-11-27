import 'package:flutter/material.dart';
import 'package:lecture_code/common/constants/shared_preferences_keys.dart';
import 'package:lecture_code/features/auth/data/repository/login_repository.dart';
import 'package:lecture_code/features/auth/domain/usecases/login_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier{
  bool isLoggedIn = false;

  final LoginUsercase loginUsecase = LoginUsercase(LoginRepositoryImpl());

  Future<void> login(String email, String password) async{
    isLoggedIn = await loginUsecase.call(params: LoginParams(email, password));
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLoggedInKey, isLoggedIn);
    notifyListeners();
  }
}
