import '../../../events/domain/entity/event.dart';
import '../../data/model/user.dart';

class UserEntity {
  final String? uid;
  final String? name;
  final String? email;
  final String? phoneNumber;
  List<UserEntity> friendsList; // Now it's a final list that must be provided at creation
  List<EventEntity> eventsList;

  UserEntity(this.uid, this.name, this.email, this.phoneNumber, this.friendsList, this.eventsList);

  factory UserEntity.fromUserModel(UserModel userModel) {
    return UserEntity(
      userModel.uid as String,
      userModel.name as String,
      userModel.email as String,
      userModel.phoneNumber as String,
      [], // Initialize with an empty list
      [], // Initialize with an empty list
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'friendsList': friendsList.map((friend) => friend.toMap()).toList(),
      'eventsList': eventsList,
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
