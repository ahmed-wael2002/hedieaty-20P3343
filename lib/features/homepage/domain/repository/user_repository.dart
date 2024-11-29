import 'package:lecture_code/features/homepage/domain/entity/user.dart';

abstract class UserRepository{
  Future<UserEntity?> fetchUser(String userId);
  Future<bool?> createUser(UserEntity user);
}