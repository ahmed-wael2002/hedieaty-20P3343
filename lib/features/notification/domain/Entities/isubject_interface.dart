import 'iobserver_interface.dart';

abstract class ISubject{
  void registerObserver(IObserver observer);
  void removeObserver(IObserver observer);
  void notifyObservers();
}