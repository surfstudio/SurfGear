import 'package:flutter_template/domain/debug_push_message.dart';
import 'package:flutter_template/interactor/common/push/debug_screen_strategy.dart';
import 'package:push_notification/push_notification.dart';

class PushStrategyFactory extends PushHandleStrategyFactory {
  @override
  Map<String, StrategyBuilder> get map => {
        "debug": (payload) {
          var message = DebugPushMessage.fromMap(payload);
          return DebugScreenStrategy(message);
        },
      };

  @override
  get defaultStrategy => (payload) {
        var message = DebugPushMessage.fromMap(payload);
        return DebugScreenStrategy(message);
      };
}
