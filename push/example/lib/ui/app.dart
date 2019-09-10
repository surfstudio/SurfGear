import 'package:flutter/material.dart';
import 'package:push/push.dart';
import 'package:push_demo/ui/main_screen.dart';

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
