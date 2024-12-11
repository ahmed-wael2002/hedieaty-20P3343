import 'package:lecture_code/features/homepage/domain/entity/user.dart';

abstract class UserRepository{
  Future<UserEntity?> fetchUser(String userId);
  Future<UserEntity?> getUserByPhoneNumber(String phoneNumber);
  Future<bool?> createUser(UserEntity user);
  Future<bool?> updateUser(UserEntity user);
  Future<bool?> deleteUser(UserEntity user);
  Future<bool?> addFriend(UserEntity me, String phoneNumber);
  Future<List<UserEntity>?> getAllFriends(String userId);
  Future<bool?> removeFriend(UserEntity me, UserEntity friend);
}