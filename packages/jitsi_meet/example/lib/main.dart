import 'package:flutter/material.dart';

import 'package:jitsi_meet/src/jitsi_meet_controller.dart';
import 'package:jitsi_meet/src/jitsi_meet_widget.dart';
import 'package:jitsi_meet_example/first_screen.dart';
import 'package:permission/base/permission_manager.dart';
import 'package:permission/impl/default_permission_manager.dart';
import 'package:permission/impl/strategy/default_proceed_permission_strategy_storage.dart';
import 'package:permission/impl/strategy/proceed_permission_strategy_example.dart';

void main() {
  runApp(
    MaterialApp(
      home: FirstScreen(),
    ),
  );
}
