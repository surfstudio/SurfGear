import 'package:ci/tasks/handler_error/error_handler.dart';
import 'package:ci/tasks/handler_error/strategy_factory.dart';

/// Standard error handler.
class StandardErrorHandler extends ErrorHandler {
  final StrategyFactory _baseStrategyFactory;

  StandardErrorHandler(this._baseStrategyFactory);

  @override
  Future<void> handler(Exception exception) async {
    var fun = _baseStrategyFactory.getStrategy(exception);
    await fun(exception);
  }
}
