import 'package:flutter/material.dart';
import 'package:push_notification/push_notification.dart';

import 'notification/example_factory.dart';
import 'notification/messaging_service.dart';
import 'ui/app.dart';
import 'ui/first_screen.dart';

///todo sample not working
///need to remove Logger inside native push module from android-standart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MessagingService messagingService = MessagingService();
  PushHandler pushHandler = PushHandler(
    ExampleFactory(),
    NotificationController(),
    messagingService,
  );
  messagingService.requestNotificationPermissions();

  runApp(MyApp(
    pushHandler,
  ));
}
