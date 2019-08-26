import 'package:flutter/material.dart';
import 'package:push/push.dart';
import 'package:push_demo/example_payload.dart';
import 'package:push_demo/message_screen.dart';

class ExampleStrategy extends BasePushHandleStrategy<ExamplePayload> {
  @override
  void extractPayloadFromMap(Map<String, dynamic> map) {
    payload = ExamplePayload(
      map['payloadInt'],
      map['payloadString'],
    );
  }

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
