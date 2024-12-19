
import 'iobserver_interface.dart';
import 'isubject_interface.dart';

class AddFriendSubject implements ISubject{
  String _friendName = '';
  String _friendToken = '';
  String _title = '';
  String _body = '';
  final List<IObserver> _observers = [];

  @override
  void notifyObservers() {
    for (IObserver observer in _observers){
      observer.update({
        'title': _title,
        'body': _body,
        'token': _friendToken
      });
    }
  }

  @override
  void registerObserver(IObserver observer) {
    _observers.add(observer);
  }

  @override
  void removeObserver(IObserver observer) {
    _observers.remove(observer);
  }

  void notifyFriend({
    required String friendName,
    required String friendToken,
  }){
    _friendToken = friendToken;
    _friendName = friendName;
    _title = 'New Follower';
    _body = '$_friendName started following your events';
    notifyObservers();
  }
}