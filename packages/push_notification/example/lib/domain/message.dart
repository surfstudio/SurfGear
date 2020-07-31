import 'package:push_notification/push_notification.dart';

class Message extends NotificationPayload {
  Message(
    Map<String, dynamic> messageData,
    String title,
    String body,
    this.extraInt,
    this.extraDouble,
  ) : super(messageData, title, body);

  factory Message.fromMap(Map<String, Object> map) {
    return Message(
      map,
      (map['notification'] as Map<String, Object>)['title'] as String,
      (map['notification'] as Map<String, Object>)['body'] as String,
      map['extraInt'] as int ?? 0,
      map['extraDouble'] as double ?? 0.0,
    );
  }

  final int extraInt;
  final double extraDouble;
}
