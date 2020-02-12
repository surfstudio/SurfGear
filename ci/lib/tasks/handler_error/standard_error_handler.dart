import 'package:ci/tasks/handler_error/error_handler.dart';
import 'package:ci/tasks/handler_error/strategy_factory.dart';

/// Standard error handler.
class StandardErrorHandler extends ErrorHandler {
  final StrategyFactory _strategyFactory;

  StandardErrorHandler(this._strategyFactory);

  @override
  Future<void> handle(Exception exception, StackTrace stackTrace) async {
    var _strategy = _strategyFactory.getStrategy(exception);
    return _strategy(exception, stackTrace);
  }
}
