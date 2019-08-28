import 'package:flutter/material.dart';
import 'package:push/push.dart';
import 'package:push_demo/ui/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String appTitle = 'Push demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [PushObserver()],
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MessageScreen(),
    );
  }
}
