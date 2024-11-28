import 'dart:core';
import 'package:lecture_code/common/usecases/usecase.dart';
import 'package:lecture_code/features/auth/domain/repository/auth_repository.dart';
import 'login_params.dart';

class RegisterUsecase implements UseCase<bool, LoginParams>{
  final AuthRepository _registerRepository;

  RegisterUsecase(this._registerRepository);

  @override
  Future<bool> call({LoginParams ? params}) async{
    return await _registerRepository.register(params!.name, params.email, params.password);
  }
}

