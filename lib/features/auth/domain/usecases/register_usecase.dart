import 'package:lecture_code/features/auth/domain/usecases/usecase_parameters.dart';

import '../../../../common/usecases/usecase.dart';
import '../repository/auth_repository.dart';

class RegisterUseCase extends UseCase<String?, RegisterParams> {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  @override
  Future<String?> call({RegisterParams? params}) async {
    if(params == null){
      throw Exception('params cannot be null!');
    }

    return await _authRepository.register(
      params.name,
      params.email,
      params.password,
      params.phoneNumber
    );
  }
}
