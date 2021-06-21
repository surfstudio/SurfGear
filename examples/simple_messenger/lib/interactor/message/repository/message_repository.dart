import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_messenger/data/message.dart';
import 'package:simple_messenger/utils/constants.dart';

class MessageRepository {
  final FirebaseFirestore _source;

  const MessageRepository(this._source);

  Future<void> sendMessage(Message message) =>
      _source.collection(kMessageCollection).add(message.toMap());

  Stream<List<Message>> getMessages() => _source
      .collection(kMessageCollection)
      .orderBy(kTimestampField)
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
