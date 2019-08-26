import 'package:logger/src/remote/strategies/remote_log_strategy.dart';

///Обёртка для логирования на удалённый сервер
///с использованием различных стратегий
class RemoteLogger {
  static final _strategies = Map<Type, RemoteLogStrategy>();

  static void setUser(String id, String username, String email) {
    _forAllStrategies((strategy) => strategy.setUser(id, username, email));
  }

  static void clearUser() {
    _forAllStrategies((strategy) => strategy.clearUser());
  }

  static void log(String message) {
    _forAllStrategies((strategy) => strategy.log(message));
  }

  static void logError(dynamic error) {
    _forAllStrategies((strategy) => strategy.logError(error));
  }

  static void logInfo(String key, dynamic info) {
    _forAllStrategies((strategy) => strategy.logInfo(key, info));
  }

  static void addStrategy(RemoteLogStrategy strategy) {
    _strategies[strategy.runtimeType] = strategy;
  }

  static void removeStrategy(RemoteLogStrategy strategy) {
    _strategies.remove(strategy.runtimeType);
  }

  static void _forAllStrategies(Function(RemoteLogStrategy strategy) action) {
    _strategies.values.forEach(action);
  }
}
