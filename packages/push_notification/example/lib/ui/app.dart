import 'package:flutter/material.dart';
import 'package:push_notification/push_notification.dart';

import 'main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp(this._pushHandler, {Key key}) : super(key: key);

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
