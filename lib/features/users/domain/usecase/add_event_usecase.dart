import 'package:lecture_code/common/usecases/usecase.dart';
import 'package:lecture_code/features/users/domain/repository/user_repository.dart';

import '../../../events/domain/entity/event.dart';
import '../entity/user.dart';

class AddEventParams{
  final UserEntity user;
  final EventEntity event;
  AddEventParams(this.user, this.event);
}

class AddEventUsecase implements UseCase<void, AddEventParams>{
  final UserRepository _userRepository;
  AddEventUsecase(this._userRepository);

  @override
  Future<void> call({AddEventParams? params}) {
    return _userRepository.addEvent(params!.user, params.event);
  }

}