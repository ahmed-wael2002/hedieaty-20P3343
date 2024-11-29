import 'package:lecture_code/features/homepage/domain/entity/user.dart';
import 'package:lecture_code/features/homepage/domain/repository/user_repository.dart';

import '../../../../common/usecases/usecase.dart';

class GetUserUsecase implements UseCase<UserEntity?, String>{
  final UserRepository _userRepository;


  GetUserUsecase(this._userRepository);

  @override
  Future<UserEntity?> call({String? params}) async{
    if(params != null) {
      return await _userRepository.fetchUser(params);
    }
    return null;
  }
  
}