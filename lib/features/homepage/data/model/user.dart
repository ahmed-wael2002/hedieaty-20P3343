
import 'package:lecture_code/features/homepage/domain/entity/user.dart';

class UserModel {
  final List<dynamic> friendsIds;
  final String? uid;
  final String? name;
  final String? email;
  final String? phoneNumber;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.friendsIds
  });

  factory UserModel.fromMap(Map<String, dynamic> userData) {
    return UserModel(
        uid: userData['id'] as String,
        name: userData['name'] as String,
        email: userData['email'] as String,
        phoneNumber: userData['phoneNumber'] as String,
        friendsIds: userData['friends'] as List<dynamic>
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'friends': friendsIds,
    };
  }

  factory UserModel.fromEntity(UserEntity userData) {
    return UserModel(
      uid: userData.uid.toString(), // Ensure uid is a string
      name: userData.name,
      email: userData.email,
      phoneNumber: userData.phoneNumber,
      friendsIds: userData.friendsList.map((friend) => friend.uid.toString()).toList(), // Ensure friends' uids are strings
    );
  }


}
