import 'package:flutter/material.dart';
import 'package:push_notification/push_notification.dart';

import 'notification/example_factory.dart';
import 'notification/messaging_service.dart';
import 'ui/app.dart';

///todo sample not working
///need to remove Logger inside native push module from android-standart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final MessagingService messagingService = MessagingService();
  final PushHandler pushHandler = PushHandler(
    ExampleFactory(),
    NotificationController(() {
      // ignore: avoid_print
      print('permission denied');
    }),
    messagingService,
  );
  messagingService.requestNotificationPermissions();

  runApp(MyApp(
    pushHandler,
  ));
}
