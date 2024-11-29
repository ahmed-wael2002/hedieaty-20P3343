import 'package:firebase_auth/firebase_auth.dart';
import 'package:lecture_code/features/auth/domain/usecases/usecase_parameters.dart';

import '../../../../common/usecases/usecase.dart';
import '../repository/auth_repository.dart';

class SignInUseCase extends UseCase<String, SignInParams> {
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  @override
  Future<String> call({SignInParams? params}) async {
    if (params == null) {
      throw ArgumentError('SignInParams cannot be null');
    }

    try{
      User? user = await _authRepository.signIn(params.email, params.password);
      if(user != null){
        return user.uid;
      }
    }catch(e){
      return '';
    }
    return '';
  }
}

