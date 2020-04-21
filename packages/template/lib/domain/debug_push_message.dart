import 'package:push_notification/push_notification.dart';

class DebugPushMessage extends NotificationPayload {
  DebugPushMessage(
    Map<String, dynamic> messageData,
    String title,
    String body,
  ) : super(messageData, title, body);

  factory DebugPushMessage.fromMap(Map<String, dynamic> map) {
    return DebugPushMessage(
      map,
      map['notification']['title'],
      map['notification']['body'],
    );
  }
}
