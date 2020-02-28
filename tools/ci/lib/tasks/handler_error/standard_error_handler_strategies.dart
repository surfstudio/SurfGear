import 'package:ci/tasks/handler_error/error_handler.dart';
import 'package:ci/tasks/handler_error/error_handling_strategy_factory.dart';

/// Вызывает стратегию для обработки ошибок.
class StandardErrorHandlerStrategies extends ErrorHandler {
  final ErrorHandlingStrategyFactory _strategyFactory;

  StandardErrorHandlerStrategies(this._strategyFactory);

  @override
  Future<void> handle(Exception exception, StackTrace stackTrace) async {
    var _strategy = _strategyFactory.getStrategy(exception);
    return _strategy(exception, stackTrace);
  }
}
