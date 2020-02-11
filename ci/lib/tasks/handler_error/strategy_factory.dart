import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/handler_error/map_error_strategy.dart';

/// Factory of strategy.
class StrategyFactory {
  /// Map стратегий обработок ошибок
  final Map<Type, errorStrategy> _mapErrorStrategy;

  /// Неизвестная ошибка
  final errorStrategy _unknownExceptionHandling;

  StrategyFactory(
    this._mapErrorStrategy,
    this._unknownExceptionHandling,
  );

  errorStrategy getStrategy(Exception error) {
    var type = error.runtimeType;
    if (error is BaseCiException) {
      if (_mapErrorStrategy.containsKey(type)) {
        return _mapErrorStrategy[type];
      }
      return _mapErrorStrategy[BaseCiException];
    }
    return _unknownExceptionHandling;
  }
}
