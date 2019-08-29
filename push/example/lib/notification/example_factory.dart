import 'package:push/push.dart';
import 'package:push_demo/domain/message.dart';
import 'package:push_demo/notification/first_strategy.dart';
import 'package:push_demo/notification/second_strategy.dart';

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
}
