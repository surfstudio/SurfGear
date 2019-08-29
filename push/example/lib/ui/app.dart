import 'package:flutter/material.dart';
import 'package:push/push.dart';
import 'package:push_demo/notification/example_factory.dart';
import 'package:push_demo/ui/main_screen.dart';

void main() {
  PushHandler pushHandler;
  MessagingService messagingService;

  pushHandler = PushHandler(
    ExampleFactory(),
    NotificationController(androidMipMapIcon),
  );
  messagingService = MessagingService(pushHandler);
  messagingService.requestNotificationPermissions();

  runApp(MyApp(
    pushHandler,
  ));
}

class MyApp extends StatelessWidget {
  MyApp(this._pushHandler);

  final PushHandler _pushHandler;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        PushObserver(),
      ],
      title: 'Push demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MessageScreen(_pushHandler),
    );
  }
}
