import 'package:flutter/material.dart';
import 'package:push/push.dart';
import 'package:push_demo/notification/example_factory.dart';
import 'package:push_demo/ui/app.dart';
import 'package:push_demo/ui/first_screen.dart';

void main() {
  MessagingService messagingService = MessagingService();
  PushHandler pushHandler = PushHandler(
    ExampleFactory(),
    NotificationController(androidMipMapIcon),
    messagingService,
  );
  messagingService.requestNotificationPermissions();

  runApp(MyApp(
    pushHandler,
  ));
}
