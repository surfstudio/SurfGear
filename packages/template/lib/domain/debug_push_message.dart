import 'package:push_notification/push_notification.dart';
import 'package:flutter_template/util/extensions.dart';

class DebugPushMessage extends NotificationPayload {
  DebugPushMessage(
    Map<String, dynamic> messageData,
    String title,
    String body,
  ) : super(messageData, title, body);

  factory DebugPushMessage.fromMap(Map<String, dynamic> map) {
    final notificationJson = map.get<Map<String, dynamic>>('notification');
    return DebugPushMessage(
      map,
      notificationJson.get<String>('title'),
      notificationJson.get<String>('body'),
    );
  }
}
