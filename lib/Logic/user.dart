import 'event.dart';

class User {
  String _name;
  String _email;
  String _password;
  String _imageUrl;
  int _upcomingEvents = 0;  // This will be changed in the future by the Event class
  int _numberFriends = 0; // counts the number of friends in the user
  List<User>? _friendsList; // This is will be changed to a list of indices
  List<Event>? _eventsList; // This is will be changed to a list of indices

  User(this._name, this._email, this._password, this._imageUrl) {
    _friendsList = [];
    _eventsList = [];
  }

  String get name => _name;
  set name(String value) {
    _name = value;
  }

  // Function to add a new friend to an existing list of friends
  bool addFriend(User user) {
    _numberFriends++;
    _friendsList?.add(user);
    return _friendsList != null;
  }

  bool removeFriend(User user) {
    _numberFriends--;
    return _friendsList?.remove(user) ?? false;
  }

  // Function to add a new friend to an existing list of friends
  bool addEvent(Event event) {
    _upcomingEvents++;
    _eventsList?.add(event);
    return _eventsList != null;
  }

  bool removeEvent(Event event) {
    _upcomingEvents--;
    return _eventsList?.remove(event) ?? false;
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

  int get numberFriends => _numberFriends;

  List<Event>? get eventsList => _eventsList;
}
