import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_messenger/utils/constants.dart';

class Message {
  final String sender;
  final String content;
  final DateTime sendTime;

  const Message({
    required this.sender,
    required this.content,
    required this.sendTime,
  });

  factory Message.fromMap(Map<String, Object> map) => Message(
        sender: map[kSenderField] as String? ?? '',
        content: map[kContentField] as String? ?? '',
        sendTime:
            (map[kTimestampField] as Timestamp? ?? Timestamp(0, 0)).toDate(),
      );

  Map<String, Object> toMap() => <String, Object>{
        kSenderField: sender,
        kContentField: content,
        kTimestampField: Timestamp.fromDate(sendTime),
      };
}
