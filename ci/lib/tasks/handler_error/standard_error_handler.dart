import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/handler_error/base_strategy_factory.dart';
import 'package:ci/tasks/handler_error/error_handler.dart';

/// Standard error handler.
class StandardErrorHandler extends ErrorHandler {
  final BaseStrategyFactory _baseStrategyFactory;

  StandardErrorHandler(this._baseStrategyFactory);

  void _baseError(BaseCiException error) {
    var fun = _baseStrategyFactory.handleError(error);
    fun(error);
  }

  void _unknownError(Exception error) {
    _baseStrategyFactory.unknownError(error);
  }

  @override
  void handler(Exception exception) {
    if (exception is BaseCiException) {
      _baseError(exception);
    } else {
      _unknownError(exception);
    }
  }
}
