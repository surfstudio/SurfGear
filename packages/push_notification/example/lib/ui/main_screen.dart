import 'package:flutter/material.dart';
import 'package:push_notification/push_notification.dart';

import '../domain/message.dart';

const String androidMipMapIcon = "@mipmap/ic_launcher";

class MessageScreen extends StatefulWidget {
  MessageScreen(this.pushHandler);

  final PushHandler pushHandler;

  @override
  MessageScreenState createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  final List<Message> messageList = [];

  @override
  void initState() {
    super.initState();

    widget.pushHandler.messageSubject.listen((messageMap) {
      var message = Message.fromMap(messageMap);
      setState(() {
        messageList.add(message);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push demo'),
      ),
      body: ListView.builder(
        itemCount: messageList.length,
        itemBuilder: buildMessage,
      ),
    );
  }

  Widget buildMessage(BuildContext context, int index) {
    final message = messageList[index];
    return ListTile(
      title: Text(message.title),
      subtitle: Text(message.body),
    );
  }
}
