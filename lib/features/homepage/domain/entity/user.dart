class UserEntity {
  final String? uid;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final List<String> friendsList;
  final List<String> eventsList;

  UserEntity(this.uid, this.name, this.email, this.phoneNumber, this.friendsList, this.eventsList);
}
