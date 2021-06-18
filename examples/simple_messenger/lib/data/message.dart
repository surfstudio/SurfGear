import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  const Message({
    required this.sender,
    required this.content,
    required this.sendTime,
  });

  final String sender;
  final String content;
  final DateTime sendTime;

  factory Message.fromMap(Map<String, dynamic> map) => Message(
        sender: map['sender'] as String? ?? '',
        content: map['content'] as String? ?? '',
        sendTime: (map['timestamp'] as Timestamp? ?? Timestamp(0, 0)).toDate(),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'sender': sender,
        'content': content,
        'timestamp': Timestamp.fromDate(sendTime)
      };
}
