import 'package:lecture_code/features/users/domain/entity/user.dart';

import '../../../events/domain/entity/event.dart';

abstract class UserRepository{
  Future<UserEntity?> fetchUser(String userId);
  Future<UserEntity?> getUserByPhoneNumber(String phoneNumber);
  Future<bool?> createUser(UserEntity user);
  Future<bool?> updateUser(UserEntity user);
  Future<bool?> deleteUser(UserEntity user);
  Future<bool?> addFriend(UserEntity me, String phoneNumber);
  Future<List<UserEntity>?> getAllFriends(String userId);
  Future<bool?> removeFriend(UserEntity me, UserEntity friend);
  Future<bool?> addEvent(UserEntity me, EventEntity newEvent);
  Future<bool?> removeEvent(UserEntity me, EventEntity event);
}