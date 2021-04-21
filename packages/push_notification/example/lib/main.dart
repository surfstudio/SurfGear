// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:push_notification/push_notification.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Notificator notification;

  String _bodyText = 'notification test';
  String notificationKey = 'key';

  @override
  void initState() {
    super.initState();
    notification = Notificator(
      onPermissionDecline: () {
        // ignore: avoid_print
        print('permission decline');
      },
      onNotificationTapCallback: (notificationData) {
        setState(
          () {
            _bodyText = 'notification open: '
                '${notificationData[notificationKey].toString()}';
          },
        );
      },
    )..requestPermissions(
        requestSoundPermission: true,
        requestAlertPermission: true,
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
              'hello',
              'this is test',
              imageUrl: 'https://www.lumico.io/wp-019/09/flutter.jpg',
              data: {notificationKey: '[notification data]'},
              notificationSpecifics: NotificationSpecifics(
                AndroidNotificationSpecifics(
                  autoCancelable: true,
                ),
              ),
            );
          },
          child: const Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
