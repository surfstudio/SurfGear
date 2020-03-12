import 'package:flutter/material.dart';
import 'package:push/push.dart';

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
    NotificationController(androidMipMapIcon),
    messagingService,
  );
  messagingService.requestNotificationPermissions();

  runApp(MyApp(
    pushHandler,
  ));
}
