import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/handler_error/map_error_strategy.dart';

/// Factory of strategy.
class StrategyFactory {
  /// Map стратегий обработок ошибок
  final Map<Type, ErrorHandlingStrategies> _mapErrorStrategy;

  StrategyFactory(
    this._mapErrorStrategy,
  );

  /// Проверяем тип ошибки для выбора стратегия
  ErrorHandlingStrategies getStrategy(Exception exception) {
    var typeException = exception.runtimeType;
    if (exception is BaseCiException) {
      if (_mapErrorStrategy.containsKey(typeException)) {
        return _mapErrorStrategy[typeException];
      }
      return _mapErrorStrategy[BaseCiException];
    }
    return _mapErrorStrategy[Exception];
  }
}
