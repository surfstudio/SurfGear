import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/handler_error/base_strategy_factory.dart';
import 'package:ci/tasks/handler_error/error_handler.dart';

/// Standard error handler.
class StandardErrorHandler extends ErrorHandler {
  final BaseStrategyFactory _baseStrategyFactory;

  StandardErrorHandler(this._baseStrategyFactory);

  @override
  void errorHandler(BaseCiException error) {
    var fun = _baseStrategyFactory.handleError(error);
    fun(error);
  }

  @override
  void unknownError(Exception error) {
    _baseStrategyFactory.unknownError(error);
  }
}
