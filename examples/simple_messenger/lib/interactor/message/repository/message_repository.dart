import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_messenger/data/message.dart';

class MessageRepository {
  final FirebaseFirestore _source;

  const MessageRepository(FirebaseFirestore source) : _source = source;

  Future<void> sendMessage(Message message) =>
      _source.collection('messages').add(message.toMap());

  Stream<List<Message>> getMessages() => _source
      .collection('messages')
      .orderBy('timestamp')
      .snapshots()
      .asyncMap<List<Message>>(_snapshotParser);

  FutureOr<List<Message>> _snapshotParser(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    final docs = snapshot.docs;

    if (docs.isEmpty) {
      return [];
    }
    return docs.map(_messageParser).toList();
  }

  Message _messageParser(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final map = doc.data();
    final message = Message.fromMap(map);

    return message;
  }
}
