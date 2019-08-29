import 'package:flutter/material.dart';
import 'package:push/push.dart';
import 'package:push_demo/domain/message.dart';
import 'package:push_demo/notification/example_factory.dart';

const String androidMipMapIcon = "@mipmap/ic_launcher";

class MessageScreen extends StatefulWidget {
  @override
  MessageScreenState createState() => new MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  final List<Message> messageList = [];

  PushHandler _pushHandler;
  MessagingService _messagingService;

  ExampleFactory _factory;
  NotificationController _notificationController;

  @override
  void initState() {
    super.initState();

    _factory = ExampleFactory();
    _notificationController = NotificationController(androidMipMapIcon);
    _pushHandler = PushHandler(
      _factory,
      _notificationController,
    );
    _messagingService = MessagingService(_pushHandler);
    _messagingService.requestNotificationPermissions();

    _pushHandler.messageSubject.listen((messageMap) {
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
