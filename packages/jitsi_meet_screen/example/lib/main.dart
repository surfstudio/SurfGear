import 'package:flutter/material.dart';
import 'package:jitsi_meet_screen/jitsi_meet_screen.dart';
import 'package:permission/base/permission_manager.dart';
import 'package:permission/impl/default_permission_manager.dart';
import 'package:permission/impl/strategy/default_proceed_permission_strategy_storage.dart';
import 'package:permission/impl/strategy/proceed_permission_strategy_example.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final jitsiScreenController = JitsiMeetScreenController(
    () => print('join'),
    () => print('will join'),
    () => print('terminated'),
  );
  final controller = TextEditingController();

  final permissions = DefaultPermissionManager(
    DefaultProceedPermissionStrategyStorage(
      strategies: Map(),
      defaultStrategy: ProceedPermissionStrategyExample(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 300,
                child: TextField(
                  controller: controller,
                ),
              ),
              RaisedButton(
                child: Text("Join room"),
                onPressed: () async {
                  final camera = await permissions.request(Permission.camera);
                  final microphone =
                      await permissions.request(Permission.microphone);
                  if (camera && microphone)
                    jitsiScreenController.joinRoom(
                      controller.value.text,
                      audioMuted: true,
                    );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
