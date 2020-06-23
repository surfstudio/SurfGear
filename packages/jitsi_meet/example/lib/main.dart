import 'package:flutter/material.dart';

import 'package:jitsi_meet/src/jitsi_meet_controller.dart';
import 'package:jitsi_meet/src/jitsi_meet_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: JitsiMeet(
          onControllerCreated: _onControllerCreated,
        ),
      ),
    );
  }

  void _onControllerCreated(JitsiMeetController controller) {}
}
