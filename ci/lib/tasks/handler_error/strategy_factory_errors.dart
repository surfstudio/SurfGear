import 'package:ci/exceptions/exceptions.dart';

/// Стратегии обработки ошибок
typedef ErrorHandlingStrategyFactory = Future<void> Function(Exception exception, StackTrace stackTrace);

/// Factory of strategy.
class StrategyFactoryErrors {
  /// Map стратегий обработок ошибок
  final Map<Type, ErrorHandlingStrategyFactory> _mapErrorStrategy;
  final ErrorHandlingStrategyFactory strategyForUnknownErrors;
  final ErrorHandlingStrategyFactory standardErrorHandlingStrategy;

  StrategyFactoryErrors(
    this._mapErrorStrategy,
    this.strategyForUnknownErrors,
    this.standardErrorHandlingStrategy,
  );

  /// Проверяем тип ошибки для выбора стратегия
  ErrorHandlingStrategyFactory getStrategy(Exception exception) {
    var typeException = exception.runtimeType;
    if (exception is BaseCiException) {
      if (_mapErrorStrategy.containsKey(typeException)) {
        return _mapErrorStrategy[typeException];
      }
      return standardErrorHandlingStrategy;
    }
    return strategyForUnknownErrors;
  }
}
