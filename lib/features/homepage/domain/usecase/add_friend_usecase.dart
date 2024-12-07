import 'package:lecture_code/features/homepage/domain/entity/user.dart';
import 'package:lecture_code/features/homepage/domain/repository/user_repository.dart';

import '../../../../common/usecases/usecase.dart';

class AddFriendParams{
  final UserEntity me;
  final String phoneNumber;

  AddFriendParams(this.me, this.phoneNumber);
}

class AddFriendUsecase implements UseCase<bool?, AddFriendParams?>{
  final UserRepository _userRepository;

  AddFriendUsecase(this._userRepository);

  @override
  Future<bool?> call({AddFriendParams? params}) async{
    if(params != null) {
      return await _userRepository.addFriend(params.me, params.phoneNumber);
    }
    return null;
  }
}