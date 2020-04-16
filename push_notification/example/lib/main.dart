import 'package:flutter/material.dart';
import 'package:push_notification/push_notification.dart';

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
      onNotificationTapCallback: (notificationData) {
        setState(
          () {
            _bodyText =
                "notification open: ${notificationData[notificationKey].toString()}";
          },
        );
      },
    );

    initPermission();
  }

  void initPermission() async {
    bool isAccept = await notification.requestPermissions(
      requestSoundPermission: true,
      requestAlertPermission: true,
    );

    print("разрешение принято:$isAccept");
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
