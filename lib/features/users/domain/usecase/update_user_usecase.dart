import 'package:lecture_code/common/usecases/usecase.dart';
import 'package:lecture_code/features/users/domain/repository/user_repository.dart';

import '../entity/user.dart';

class UpdateUserUsecase implements UseCase<bool?, UserEntity>{
  final UserRepository _userRepository;

  UpdateUserUsecase(this._userRepository);

  @override
  Future<bool?> call({UserEntity? params}) async{
    return await _userRepository.updateUser(params!);
  }

}