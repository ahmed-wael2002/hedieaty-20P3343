import 'package:lecture_code/features/auth/domain/usecases/usecase_parameters.dart';

import '../../../../common/usecases/usecase.dart';
import '../repository/auth_repository.dart';

class SignOutUseCase extends UseCase<void, NoParams> {
  final AuthRepository _authRepository;

  SignOutUseCase(this._authRepository);

  @override
  Future<void> call({NoParams? params}) async {
    await _authRepository.signOut();
  }
}
