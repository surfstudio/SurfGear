import 'package:push/push.dart';
import 'package:push_demo/notification/first_strategy.dart';
import 'package:push_demo/notification/second_strategy.dart';

class ExampleFactory extends PushHandleStrategyFactory {
  @override
  Map<String, BasePushHandleStrategy> get map => {
        "type1": FirstStrategy(),
        "type2": SecondStrategy(),
      };
}
