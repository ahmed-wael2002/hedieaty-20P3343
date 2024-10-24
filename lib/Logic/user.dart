class User {
  String _name;
  String _email;
  String _password;
  String _imageUrl;
  int _upcomingEvents = 0;  // This will be changed in the future by the Event class
  List<User>? _friendsList;

  User(this._name, this._email, this._password, this._imageUrl) {
    _friendsList = [];
  }

  String get name => _name;
  set name(String value) {
    _name = value;
  }

  // Function to add a new friend to an existing list of friends
  bool addFriend(User user) {
    _friendsList?.add(user);
    return _friendsList != null;
  }

  bool removeFriend(User user) {
    return _friendsList?.remove(user) ?? false;
  }

  // Overriding == operator and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is User && runtimeType == other.runtimeType && _name == other._name;

  @override
  int get hashCode => _name.hashCode;

  // Getters and Setters
  String get email => _email;
  List<User>? get friendsList => _friendsList;
  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }

  String get password => _password;
  set password(String value) {
    _password = value;
  }

  set email(String value) {
    _email = value;
  }

  int get upcomingEvents => _upcomingEvents;
  void addEvent() {
    _upcomingEvents++;
  }
}
