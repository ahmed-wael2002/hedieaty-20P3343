import 'user.dart';

class Gift{
  late String _name;
  bool _isPledged = false;
  late User _pledgingUser;

  Gift(this._name);

  User get pledgingUser => _pledgingUser;

  set pledgingUser(User value) {
    _pledgingUser = value;
  }

  bool get isPledged => _isPledged;

  void togglePledge(){
    _isPledged = (_isPledged == true) ? false : true;
  }


  String get name => _name;

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
}