
import 'package:lecture_code/features/notification/data/firebase_messaging_api/push_notification_service.dart';

import 'iobserver_interface.dart';
import 'isubject_interface.dart';

class NotificationObserver implements IObserver{
  String _title = '';
  String _body = '';
  String _deviceToken = '';

  NotificationObserver(ISubject subject){
    subject.registerObserver(this);
  }

  @override
  void update(Map<String, dynamic> data) {
    try{
      _title = data['title'];
      _body = data['body'];
      _deviceToken = data['token'];
    } catch(e){
      _title = '';
      _body = '';
      _deviceToken = '';
    }
    if(_deviceToken!='' && _title!='' && _body!=''){
      PushNotificationService.sendNotificationToDevice(
          deviceToken: _deviceToken,
          title: _title,
          body: _body
      );
    }
  }

}