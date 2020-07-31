import 'package:flutter/material.dart';
import 'package:jitsi_meet_example/jitsi_screen.dart';
import 'package:permission/base/permission_manager.dart';
import 'package:permission/impl/default_permission_manager.dart';
import 'package:permission/impl/strategy/default_proceed_permission_strategy_storage.dart';
import 'package:permission/impl/strategy/proceed_permission_strategy_example.dart';

class FirstScreen extends StatelessWidget {
  FirstScreen({Key key}) : super(key: key);

  final controller = TextEditingController();

  final permissions = DefaultPermissionManager(
    DefaultProceedPermissionStrategyStorage(
      strategies: {},
      defaultStrategy: ProceedPermissionStrategyExample(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example')),
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
              onPressed: () async {
                final camera = await permissions.request(Permission.camera);
                final microphone =
                    await permissions.request(Permission.microphone);
                if (camera && microphone) {
                  // ignore: unawaited_futures
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => JitsiScreen(room: controller.text),
                    ),
                  );
                }
              },
              child: const Text('Join room'),
            )
          ],
        ),
      ),
    );
  }
}
