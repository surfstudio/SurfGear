import 'package:logger/src/const.dart';
import 'package:logger/src/strategies/log_strategy.dart';

///Обёртка для логирования с использованием различных стратегий
class Logger {
  static final _strategies = Map<Type, LogStrategy>();

  ///debug
  static void d(String msg, [dynamic error]) {
    _forAllStrategies(
      (strategy) => strategy.log(msg, PRIORITY_LOG_DEBUG, error),
    );
  }

  ///warn (для ожидаемых ошибок)
  static void w(String msg, [dynamic error]) {
    _forAllStrategies(
      (strategy) => strategy.log(msg, PRIORITY_LOG_WARN, error),
    );
  }

  ///error (для ошибок)
  static void e(String msg, [dynamic error]) {
    _forAllStrategies(
      (strategy) => strategy.log(msg, PRIORITY_LOG_ERROR, error),
    );
  }

  static void addStrategy(LogStrategy strategy) {
    _strategies[strategy.runtimeType] = strategy;
  }

  static void removeStrategy(LogStrategy strategy) {
    _strategies.remove(strategy.runtimeType);
  }

  static void _forAllStrategies(Function(LogStrategy strategy) action) {
    _strategies.values.forEach(action);
  }
}
