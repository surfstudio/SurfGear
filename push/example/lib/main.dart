import 'package:flutter/material.dart';
import 'package:push_demo/message_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String appTitle = 'Push demo';

  @override
  Widget build(BuildContext context) {
    GlobalKey<NavigatorState> navigatorKey = GlobalKey();
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MessageScreen(),
    );
  }
}
