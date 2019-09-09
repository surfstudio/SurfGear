import 'package:flutter/material.dart';
import 'package:flutter_template/config/env/env.dart';
import 'package:flutter_template/ui/screen/debug/debug_screen.dart';
import 'package:push/push.dart';

/// Роут экрана <Debug>
class DebugScreenRoute extends MaterialPageRoute {
  DebugScreenRoute() : super(builder: (ctx) => DebugScreen());

  static void showDebugScreenNotification(PushHandler pushHandler) {
    if (Environment.instance().isDebug) {
      pushHandler.handleMessage(
        {
          'notification': {
            'title': 'Open debug screen',
            'body': '',
          },
          'event': 'debug',
          'data': {
            'event': 'debug',
          },
        },
        MessageHandlerType.onMessage,
        localNotification: true,
      );
    }
  }
}
