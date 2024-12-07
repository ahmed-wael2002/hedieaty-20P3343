import 'package:lecture_code/features/homepage/domain/entity/user.dart';
import 'package:lecture_code/features/homepage/domain/repository/user_repository.dart';

import '../../../../common/usecases/usecase.dart';

class AddUserUsecase implements UseCase<bool?, UserEntity?>{
  final UserRepository _userRepository;

  AddUserUsecase(this._userRepository);

  @override
  Future<bool?> call({UserEntity? params}) async{
    if(params != null) {
      return await _userRepository.createUser(params);
    }
    return null;
  }
}