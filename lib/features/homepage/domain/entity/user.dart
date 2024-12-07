import '../../data/model/user.dart';

class UserEntity {
  final String? uid;
  final String? name;
  final String? email;
  final String? phoneNumber;
  List<UserEntity> friendsList; // Now it's a final list that must be provided at creation
  final List<String> eventsList;

  UserEntity(this.uid, this.name, this.email, this.phoneNumber, this.friendsList, this.eventsList);

  void addFriend(UserEntity? friend) {
    if(friend != null){
      friendsList.add(friend);
    }
  }

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

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'friendsList': friendsList.map((friend) => friend.toJson()).toList(),
      'eventsList': eventsList,
    };
  }
}
