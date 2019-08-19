import 'package:flutter/material.dart';
import 'package:push/push.dart';
import 'package:push_demo/message.dart';

class MessageWidget extends StatefulWidget {
  @override
  _MessageWidgetState createState() => new _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  final List<Message> messages = [];

  PushManager pushManager = PushManager();

  @override
  void initState() {
    super.initState();

    pushManager.initNotification(
      onMessage: (message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
            title: notification['title'],
            body: notification['body'],
          ));
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];
        setState(() {
          messages.add(Message(
            title: '${notification['title']}',
            body: '${notification['body']}',
          ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: messages.length,
        itemBuilder: buildMessage,
      );

  Widget buildMessage(BuildContext context, int index) {
    final message = messages[index];
    return ListTile(
      title: Text(message.title),
      subtitle: Text(message.body),
    );
  }
}
