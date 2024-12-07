import 'package:lecture_code/features/homepage/domain/entity/user.dart';
import 'package:lecture_code/features/homepage/domain/repository/user_repository.dart';

import '../../../../common/usecases/usecase.dart';

class GetAllFriendsUsecase implements UseCase<List<UserEntity>?, String> {
  final UserRepository _userRepository;

  GetAllFriendsUsecase(this._userRepository);

  @override
  Future<List<UserEntity>?> call({String? params}) async {
    if (params != null) {
      return await _userRepository.getAllFriends(params);
    }
    return null;
  }
}