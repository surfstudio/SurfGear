import 'package:push_notification/push_notification.dart';

import '../domain/message.dart';
import 'first_strategy.dart';
import 'second_strategy.dart';

class ExampleFactory extends PushHandleStrategyFactory {
  @override
  Map<String, StrategyBuilder> get map => {
        "type1": (payload) {
          var message = Message.fromMap(payload);
          return FirstStrategy(message);
        },
        "type2": (payload) {
          var message = Message.fromMap(payload);
          return SecondStrategy(message);
        },
      };

  @override
  StrategyBuilder get defaultStrategy {
    return (payload) => FirstStrategy(
          Message.fromMap(payload),
        );
  }
}
