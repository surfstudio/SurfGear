import 'package:flutter/material.dart';
import 'package:push/push.dart';
import 'package:push_demo/example_payload.dart';
import 'package:push_demo/message_screen.dart';

class ExampleStrategy extends BasePushHandleStrategy<ExamplePayload> {
  @override
  void onTapNotification(NavigatorState navigator) {
    debugPrint('on tap notification');

    navigator.pushReplacement(
      MaterialPageRoute(
        builder: (context) => MessageScreen(),
      ),
    );
  }
}
