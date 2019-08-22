import 'package:push/push.dart';
import 'package:push_demo/example_strategy.dart';

class ExampleFactory extends PushHandleStrategyFactory {
  @override
  Map<String, BasePushHandleStrategy> get map => {
        "type1": ExampleStrategy(),
        "type2": ExampleStrategy(),
      };
}
