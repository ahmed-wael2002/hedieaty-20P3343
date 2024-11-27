import 'dart:core';
import 'package:lecture_code/common/usecases/usecase.dart';
import 'package:lecture_code/features/auth/domain/repository/login_repository.dart';

class LoginUsercase implements UseCase<bool, LoginParams>{
  final LoginRepository _loginRepository;

  LoginUsercase(this._loginRepository);

  @override
  Future<bool> call({LoginParams ? params}) async{
    return await _loginRepository.login(params!.email, params.password);
  }
}


class LoginParams {
  final String email;
  final String password;

  LoginParams(this.email, this.password);
}

