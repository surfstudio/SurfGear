import 'package:flutter/material.dart';

import 'package:jitsi_meet/src/jitsi_meet_controller.dart';
import 'package:jitsi_meet/src/jitsi_meet_widget.dart';
import 'package:permission/base/permission_manager.dart';
import 'package:permission/impl/default_permission_manager.dart';
import 'package:permission/impl/strategy/default_proceed_permission_strategy_storage.dart';
import 'package:permission/impl/strategy/proceed_permission_strategy_example.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Example',
      home: MainScreen(),
    ),
  );
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final permissionManager = DefaultPermissionManager(
    DefaultProceedPermissionStrategyStorage(
      strategies: Map(),
      defaultStrategy: ProceedPermissionStrategyExample(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("tap me"),
          onPressed: () async {
            final camera = await permissionManager.request(Permission.camera);
            final microphone =
                await permissionManager.request(Permission.microphone);
            if (camera && microphone) {
              navigator.push(
                MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      body: buildLayoutBuilder(),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  LayoutBuilder buildLayoutBuilder() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: JitsiMeetWidget(
            onControllerCreated: _onControllerCreated,
          ),
        );
      },
    );
  }

  void _onControllerCreated(JitsiMeetController controller) {}
}
