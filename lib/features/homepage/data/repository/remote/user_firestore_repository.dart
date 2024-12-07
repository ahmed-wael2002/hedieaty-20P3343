import 'package:lecture_code/features/homepage/data/data_sources/remote/firestore_singleton.dart';
import 'package:lecture_code/features/homepage/domain/entity/user.dart';
import 'package:lecture_code/features/homepage/domain/repository/user_repository.dart';

import '../../model/user.dart';

class FirestoreRepositoryImpl implements UserRepository {

  final UserFirestore _firestore = UserFirestore.instance;

  @override
  Future<UserEntity?> fetchUser(String? userId) async {
    try {
      // Step 1: Fetch the user data by userId
      var result = await _firestore.getUserById(userId!);
      if (result == null || result.isEmpty) {
        return null; // No user found
      }

      // Step 2: Convert the fetched data into a UserModel
      UserModel user = UserModel.fromMap(result);

      // Step 4: Populate the UserEntity with the list of friends
      UserEntity userEntity = UserEntity.fromUserModel(user);
      userEntity.friendsList = await getAllFriends(userEntity.uid ?? '') ?? [];

      // Step 5: Return the populated UserEntity
      return userEntity;
    } catch (e) {
      print('Error fetching user by userId: $e');
    }
    return null;
  }


  @override
  Future<bool?> createUser(UserEntity user) async {
    return _firestore.addUser(user.uid!, user.toJson());
  }

  @override
  Future<bool?> deleteUser(UserEntity user) {
    return _firestore.deleteUser(user.uid!);
  }

  @override
  Future<bool?> updateUser(UserEntity user) {
    return _firestore.updateUser(user.uid!, user.toJson());
  }

  @override
  Future<UserEntity?> getUserByPhoneNumber(String phoneNumber) async {
    try {
      var results = await _firestore.getUserByPhoneNumber(phoneNumber);
      if (results.isNotEmpty) {
        UserModel user = UserModel.fromMap(results[0]);
        return UserEntity.fromUserModel(user);
      }
    } catch (e) {
      print('Error in User remote repository implementation: $e');
    }
    return null;
  }

  @override
  Future<bool?> addFriend(UserEntity me, String phoneNumber) async {
    // Get the friend data based on the phone number
    try {
      var friendMap = await _firestore.getUserByPhoneNumber(phoneNumber);
      if (friendMap != null && friendMap.isNotEmpty) {
        UserModel friend = UserModel.fromMap(friendMap);
        me.addFriend(UserEntity.fromUserModel(friend));
        UserModel userModel = UserModel.fromEntity(me);
        return await _firestore.updateUser(me.uid!, userModel.toJson());
      } else {
        return false;
      }
    } catch (e) {
      print('Error adding friend: $e');
      return false;
    }
  }

  @override
  Future<List<UserEntity>?> getAllFriends(String userId) async {
    try {
      // Step 1: Fetch the user by userId
      var userMap = await _firestore.getUserById(userId);
      if (userMap == null || userMap.isEmpty) {
        return null; // No user found
      }

      // Step 2: Convert the userMap into a UserModel
      UserModel user = UserModel.fromMap(userMap);

      // Step 3: Extract the list of friends' ids (assuming it's a List of Strings)
      var friendIds = user.friendsIds;

      // Step 4: Fetch each friend's data by their userId
      List<UserEntity> friends = [];
      for (String friendId in friendIds) {
        var friendMap = await _firestore.getUserById(friendId);
        if (friendMap != null && friendMap.isNotEmpty) {
          // Convert friend map to UserModel and then to UserEntity
          UserModel friend = UserModel.fromMap(friendMap);
          friends.add(UserEntity.fromUserModel(friend));
        }
      }

      // Step 5: Return the list of friends
      return friends;
    } catch (e) {
      print('Error fetching all friends: $e');
      return null;
    }
  }

}
