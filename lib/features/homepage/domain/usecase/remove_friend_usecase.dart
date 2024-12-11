import 'package:lecture_code/features/homepage/domain/entity/user.dart';
import 'package:lecture_code/features/homepage/domain/repository/user_repository.dart';

import '../../../../common/usecases/usecase.dart';

class RemoveFriendParams{
  final UserEntity me;
  final UserEntity friend;

  RemoveFriendParams(this.me, this.friend);
}

class RemoveFriendUsecase implements UseCase<bool?, RemoveFriendParams?>{
  final UserRepository _userRepository;

  RemoveFriendUsecase(this._userRepository);

  @override
  Future<bool?> call({RemoveFriendParams? params}) async{
    if(params != null) {
      return await _userRepository.removeFriend(params.me, params.friend);
    }
    return null;
  }
}