import 'package:lecture_code/features/homepage/data/data_sources/remote/firestore_singleton.dart';
import 'package:lecture_code/features/homepage/domain/entity/user.dart';
import 'package:lecture_code/features/homepage/domain/repository/user_repository.dart';

import '../../model/user.dart';

class FirestoreRepositoryImpl implements UserRepository {
  @override
  @override
  Future<UserEntity?> fetchUser(String? userId) async {
    if (userId != null) {
      try {
        // Fetch user data from Firestore
        Map<String, dynamic>? userData = await FirestoreDataSource.instance.getUser(userId);

        if (userData != null) {
          // Convert the fetched data to a UserModel
          UserModel userModel = UserModel.fromMap(userData);

          // Fetch the user's friends based on their UIDs
          List<UserEntity> userFriends = [];
          for (String friendId in userModel.friendsIds) {
            Map<String, dynamic>? friendData = await FirestoreDataSource.instance.getUser(friendId);
            if (friendData != null) {
              UserModel friendModel = UserModel.fromMap(friendData);
              userFriends.add(UserEntity.fromUserModel(friendModel));
            }
          }

          // Initialize the UserEntity with the fetched friends
          return UserEntity(
            userModel.uid,
            userModel.name,
            userModel.email,
            userModel.phoneNumber,
            userFriends, // Pass friendsList directly here
            [], // Initialize events list
          );
        }
      } catch (e) {
        print('Error fetching user: $e');
      }
    }

    return null;
  }


  @override
  Future<bool?> createUser(UserEntity user) async {
    try {
      // Convert UserEntity to a map using toJson
      final userMap = user.toJson();

      // Save the user to Firestore using FirestoreDataSource
      await FirestoreDataSource.instance.addUser(user.uid!, userMap);

      // Return true if user creation succeeds
      return true;
    } catch (e) {
      // Handle any errors that occur during Firestore write
      print('Error creating user: $e');
      return false;
    }
  }
}
