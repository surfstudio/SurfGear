import 'package:push_notification/push_notification.dart';

class Message extends NotificationPayload {
  Message(
    Map<String, dynamic> messageData,
    String title,
    String body,
    this.extraInt,
    this.extraDouble,
  ) : super(messageData, title, body);

  final int extraInt;
  final double extraDouble;

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      map,
      map['notification']['title'],
      map['notification']['body'],
      map['extraInt'] ?? 0,
      map['extraDouble'] ?? 0.0,
    );
  }
}
