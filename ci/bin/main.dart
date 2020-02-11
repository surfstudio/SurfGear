import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/handler_error/base_strategy_factory.dart';
import 'package:ci/tasks/handler_error/map_error_strategy.dart';
import 'package:ci/tasks/handler_error/standard_error_handler.dart';

void main(List<String> arguments) async {
//  await Ci.instance.execute(arguments);
  var _standardErrorHandler = StandardErrorHandler(
    BaseStrategyFactory(
      mapErrorStrategy,
      unknownErrorStrategy,
    ),
  );

  await _standardErrorHandler.handler(Exception('test'));
  await _standardErrorHandler.handler(ModulesNotFoundException('test'));
}
