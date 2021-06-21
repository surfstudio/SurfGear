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
          .asyncMap<List<Message>>((snapshot) {
        final objectSnapshot = snapshot.docs
            .map((doc) => doc.data().cast<String, Object>())
            .toList();

        return _snapshotParser(objectSnapshot);
      });

  List<Message> _snapshotParser(
    List<Map<String, Object>> docs,
  ) {
    if (docs.isEmpty) {
      return [];
    }

    return docs.map((doc) => Message.fromMap(doc)).toList();
  }
}
