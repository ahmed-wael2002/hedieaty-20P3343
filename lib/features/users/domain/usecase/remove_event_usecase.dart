import 'package:lecture_code/common/usecases/usecase.dart';

import '../../../events/domain/entity/event.dart';
import '../entity/user.dart';
import '../repository/user_repository.dart';

class RemoveEventParams{
  final UserEntity me;
  final EventEntity event;

  RemoveEventParams(this.me, this.event);
}

class RemoveEventUsecase implements UseCase<bool?, RemoveEventParams?>{
  final UserRepository _userRepository;

  RemoveEventUsecase(this._userRepository);

  @override
  Future<bool?> call({RemoveEventParams? params}) async{
    if(params != null) {
      return await _userRepository.removeEvent(params.me, params.event);
    }
    return null;
  }
}