import 'package:flutter/material.dart';
import 'package:push/push.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Notificator notification;

  String _bodyText = "notification test";
  String notificationKey = "key";

  @override
  void initState() {
    super.initState();
    notification = Notificator(
      initSettings: InitSettings(
        iosInitSettings: IOSInitSettings(
          requestAlertPermission: true,
          requestSoundPermission: true,
        ),
      ),
      onNotificationTapCallback: (notificationData) {
        setState(
          () {
            _bodyText =
                "notification open: ${notificationData[notificationKey].toString()}";
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text(_bodyText),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            notification.show(
              1,
              "hello",
              "this is test",
              data: {notificationKey: "[notification data]"},
              notificationSpecifics: NotificationSpecifics(
                AndroidNotificationSpecifics(
                  autoCancelable: true,
                ),
              ),
            );
          },
          child: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
