import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/handler_error/map_error_strategy.dart';

/// Factory of strategy.
class BaseStrategyFactory {
  /// Map стратегий обработок ошибок
  final Map<Type, errorStrategy> _mapErrorStrategy;

  /// Стандартная обработка ошибок
  final errorStrategy _baseExceptionHandling;

  /// Неизвестная ошибка
  final errorStrategy _unknownExceptionHandling;

  BaseStrategyFactory(
    this._mapErrorStrategy,
    this._baseExceptionHandling,
    this._unknownExceptionHandling,
  );

  errorStrategy handleError(BaseCiException error) {
    var type = error.runtimeType;

    if (_mapErrorStrategy.containsKey(type)) {
      return _mapErrorStrategy[type];
    }
    return _baseExceptionHandling;
  }

  errorStrategy unknownError(Exception error) {
    return _unknownExceptionHandling;
  }
}
