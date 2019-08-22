import 'package:flutter/widgets.dart';
import 'package:push/push.dart';
import 'package:push_demo/example_strategy.dart';

class ExampleFactory extends PushHandleStrategyFactory {
  ExampleFactory(GlobalKey<NavigatorState> navigatorKey) : super(navigatorKey);

  @override
  Map<String, BasePushHandleStrategy> get map => {
        "type1": ExampleStrategy(),
        "type2": ExampleStrategy(),
      };
}
