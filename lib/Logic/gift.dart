import '../features/users/domain/entity/user.dart';

class Gift{
  late String _name;
  String _imageUrl = 'assets/images/default.jpg';
  bool _isPledged = false;
  late UserEntity _pledgingUser;

  Gift(this._name, this._imageUrl);

  UserEntity get pledgingUser => _pledgingUser;

  set pledgingUser(UserEntity value) {
    _pledgingUser = value;
  }

  bool get isPledged => _isPledged;

  void togglePledge(){
    _isPledged = (_isPledged == true) ? false : true;
  }


  String get name => _name;
  String get imageUrl => _imageUrl;

  set name(String value) {
    _name = value;
  }

  // Overriding == operator and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Gift && runtimeType == other.runtimeType && _name == other._name;

  @override
  int get hashCode => _name.hashCode;

  set isPledged(bool value) {
    _isPledged = value;
  }

  set imageUrl(String value) {
    _imageUrl = value;
  }
}