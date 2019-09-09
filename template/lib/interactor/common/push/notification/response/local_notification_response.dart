import 'package:flutter_template/domain/notification.dart';
import 'package:flutter_template/interactor/base/transformable.dart';

class FirebaseNotificationResponse extends Transformable<Notification> {
  _FirebaseBodyNotificationObj notification;

  FirebaseNotificationResponse({this.notification});

  FirebaseNotificationResponse.fromMessage(Map<String, dynamic> message) {
    notification = message['notification'] != null
        ? _FirebaseBodyNotificationObj.fromMessage(message['notification'])
        : null;
  }

  @override
  Notification transform() => Notification(
        title: notification.title,
        text: notification.body,
        type: notification.data['type'],
      );
}

class _FirebaseBodyNotificationObj {
  String body;
  String title;
  Map<String, dynamic> data;

  _FirebaseBodyNotificationObj({this.body, this.title});

  _FirebaseBodyNotificationObj.fromMessage(Map<dynamic, dynamic> message) {
    body = message['body'];
    title = message['title'];
    data = message['data'];
  }
}
