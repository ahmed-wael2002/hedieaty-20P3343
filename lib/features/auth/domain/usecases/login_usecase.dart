import 'dart:core';
import 'package:lecture_code/common/usecases/usecase.dart';
import 'package:lecture_code/features/auth/domain/repository/auth_repository.dart';
import 'login_params.dart';

class LoginUsercase implements UseCase<bool, LoginParams>{
  final AuthRepository _loginRepository;

  LoginUsercase(this._loginRepository);

  @override
  Future<bool> call({LoginParams ? params}) async{
    return await _loginRepository.login(params!.email, params.password);
  }
}

