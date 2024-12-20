import '../../../events/domain/entity/event.dart';
import '../../data/model/user.dart';

class UserEntity {
  final String? fcmToken;
  final String? uid;
  final String? name;
  final String? email;
  final String? phoneNumber;
  List<UserEntity> friendsList; // Now it's a final list that must be provided at creation
  List<EventEntity> eventsList;

  UserEntity(this.uid, this.name, this.email, this.phoneNumber, this.friendsList, this.eventsList, this.fcmToken);

  factory UserEntity.fromUserModel(UserModel userModel) {
    return UserEntity(
      userModel.uid as String,
      userModel.name as String,
      userModel.email as String,
      userModel.phoneNumber as String,
      [], // Initialize with an empty list
      [], // Initialize with an empty list
      userModel.fcmToken
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fcmToken':fcmToken,
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'friends': friendsList.map((friend) => friend.toMap()).toList(),
      'events': eventsList,
    };
  }

  /* Friends Management */

  void removeFriend(UserEntity friend) {
    friendsList.remove(friend);
  }

  void addFriend(UserEntity? friend) {
    if(friend != null){
      friendsList.add(friend);
    }
  }

  /* Events Management */
  void addEvent(EventEntity event) {
    eventsList.add(event);
  }

  void removeEvent(EventEntity event) {
    eventsList.remove(event);
  }
}
