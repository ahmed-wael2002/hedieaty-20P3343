import 'package:lecture_code/features/notification/domain/Entities/iobserver_interface.dart';
import 'package:lecture_code/features/notification/domain/Entities/isubject_interface.dart';

class PledgeGiftSubject implements ISubject{
  late final String _myName;
  String _friendToken = '';
  String _giftName = '';
  final List<IObserver> _observers = [];

  PledgeGiftSubject(
    this._myName,
  );

  @override
  void notifyObservers() {
    for (var observer in _observers) {
      observer.update({
        'title': 'Pledged Gift',
        'body': '$_giftName has been pledged by $_myName',
        'token': _friendToken,
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

  void pledgeGift(String friendToken, String giftName){
    _friendToken = friendToken;
    _giftName = giftName;
    notifyObservers();
  }

}