import 'package:flutter/material.dart';
import 'package:push/push.dart';
import 'package:push_demo/example_factory.dart';
import 'package:push_demo/message.dart';

const String androidMipMapIcon = "@mipmap/ic_launcher";

class MessageScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MessageScreen({Key key, this.navigatorKey}) : super(key: key);

  @override
  MessageScreenState createState() => new MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  final List<Message> messages = [];

  PushManager _pushManager;
  ExampleFactory _factory;
  NotificationController _notificationController;

  @override
  void initState() {
    super.initState();

    _factory = ExampleFactory(widget.navigatorKey);
    _notificationController = NotificationController(
      _factory,
      androidMipMapIcon,
    );
    _pushManager = PushManager(
      _factory,
      _notificationController,
    );
    _pushManager.requestNotificationPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push demo'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: buildMessage,
      ),
    );
  }

  Widget buildMessage(BuildContext context, int index) {
    final message = messages[index];
    return ListTile(
      title: Text(message.title),
      subtitle: Text(message.body),
    );
  }
}
