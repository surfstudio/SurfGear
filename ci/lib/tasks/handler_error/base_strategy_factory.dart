import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/handler_error/map_error_strategy.dart';

/// Factory of strategy.
class BaseStrategyFactory {
  /// Map стратегий обработок ошибок
  final Map<Type, errorStrategy> _mapErrorStrategy;

  /// Неизвестная ошибка
  final errorStrategy _unknownExceptionHandling;

  BaseStrategyFactory(
    this._mapErrorStrategy,
    this._unknownExceptionHandling,
  );

  errorStrategy handleError(BaseCiException error) {
    var type = error.runtimeType;

    if (_mapErrorStrategy.containsKey(type)) {
      return _mapErrorStrategy[type];
    }
    return _mapErrorStrategy[BaseCiException];
  }

  Function unknownError() {
    return _unknownExceptionHandling;
  }
}
