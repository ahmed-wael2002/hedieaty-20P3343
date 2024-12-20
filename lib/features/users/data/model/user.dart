
import 'package:lecture_code/features/users/domain/entity/user.dart';

class UserModel {
  final String? fcmToken;
  final List<dynamic> friendsIds;
  final List<dynamic> eventsIds;
  final String? uid;
  final String? name;
  final String? email;
  final String? phoneNumber;

  UserModel({
    required this.fcmToken,
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.friendsIds,
    required this.eventsIds,
  });

  factory UserModel.fromMap(Map<String, dynamic> userData) {
    return UserModel(
      fcmToken: userData['fcmToken'] as String?,
      uid: userData['id'] as String?,
      name: userData['name'] as String?,
      email: userData['email'] as String?,
      phoneNumber: userData['phoneNumber'] as String?,
      friendsIds: List<dynamic>.from(userData['friends'] ?? []),
      eventsIds: List<dynamic>.from(userData['events'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fcmToken' : fcmToken,
      'id': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'friends': friendsIds,
      'events': eventsIds,
    };
  }

  factory UserModel.fromEntity(UserEntity userData) {
    return UserModel(
      fcmToken: userData.fcmToken,
      uid: userData.uid.toString(), // Ensure uid is a string
      name: userData.name,
      email: userData.email,
      phoneNumber: userData.phoneNumber,
      friendsIds: userData.friendsList.map((friend) => friend.uid.toString()).toList(), // Ensure friends' uids are strings
      eventsIds: userData.eventsList.map((event) => event.id.toString()).toList(), // Ensure events' ids are strings
    );
  }


}
