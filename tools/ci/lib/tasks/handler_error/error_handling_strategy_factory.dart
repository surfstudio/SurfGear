import 'package:ci/exceptions/exceptions.dart';

/// Псевдоним функции стратегии обработки ошибок
typedef ErrorHandlingStrategies = Future<void> Function(Exception exception, StackTrace stackTrace);

/// Фабрика стратегий обработки ошибок.
///
/// Возвращаем стратегию обработки ошибок CI модуля.
/// Если тип ошибки не относится к модулю CI то возвращаем стратегию [_strategyForUnknownErrors]
class ErrorHandlingStrategyFactory {
  /// Map стратегий обработок ошибок
  final Map<Type, ErrorHandlingStrategies> _mapErrorStrategy;

  /// Стандартная обработка ошибок [BaseCiException]
  final ErrorHandlingStrategies _standardErrorHandlingStrategy;

  /// Обработчик ошибок не модуля CI
  final ErrorHandlingStrategies _strategyForUnknownErrors;

  ErrorHandlingStrategyFactory(
    this._mapErrorStrategy,
    this._standardErrorHandlingStrategy,
    this._strategyForUnknownErrors,
  );

  /// Возвращает стратегию обработки ошибки
  ErrorHandlingStrategies getStrategy(Exception exception) {
    var typeException = exception.runtimeType;
    if (exception is BaseCiException) {
      if (_mapErrorStrategy.containsKey(typeException)) {
        return _mapErrorStrategy[typeException];
      }
      return _standardErrorHandlingStrategy;
    }
    return _strategyForUnknownErrors;
  }
}
