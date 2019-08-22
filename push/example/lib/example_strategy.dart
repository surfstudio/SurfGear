import 'package:flutter/cupertino.dart';
import 'package:push/push.dart';
import 'package:push_demo/example_payload.dart';
import 'package:push_demo/message_screen_route.dart';

class ExampleStrategy extends BasePushHandleStrategy<ExamplePayload> {
  @override
  void extractPayloadFromMap(Map<String, dynamic> map) {
    payload = ExamplePayload(
      map['payloadInt'],
      map['payloadString'],
    );
  }

  @override
  void onTapNotification() {
    debugPrint('on tap notification');
    navigatorKey.currentState.pushReplacement(MessageScreenRoute(
      navigatorKey: navigatorKey,
    ));
  }

  void _internalOnTapHandler(BuildContext context) {
    debugPrint('on tap notification with context');
  }
}
