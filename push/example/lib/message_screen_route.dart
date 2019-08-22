import 'package:flutter/material.dart';
import 'package:push/push.dart';
import 'package:push_demo/message_screen.dart';

/// Роут экрана [ShowCardScreen]
class MessageScreenRoute extends MaterialPageRoute {
  MessageScreenRoute({
    GlobalKey<NavigatorState> navigatorKey,
    StrategyOnTapHandler onTapHandler,
  }) : super(
          builder: (ctx) {
            if (onTapHandler != null) {
              onTapHandler(ctx);
            }
            return MessageScreen(
              navigatorKey: navigatorKey,
            );
          },
        );
}
