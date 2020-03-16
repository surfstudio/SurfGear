import 'dart:io';

import 'package:ci/tasks/handler_error/error_handling_strategy_factory.dart';

/// Стратегия для ошибок не относящиеся к модулю CI
Future<void> strategyForUnknownErrors(Exception exception, StackTrace stackTrace) {
  print('unknownErrorStrategy: ${exception}');
  return Future.error(exception, stackTrace);
}

/// Стандартная стратегия обработки ошибок модуля CI
Future<void> standardErrorHandlingStrategy(Exception exception, StackTrace stackTrace) async {
  print(exception);
  exitCode = 1;
}

Map<Type, ErrorHandlingStrategies> _mapErrorStrategy = {};

/// Геттер мапы, со стратегиями обработок ошибок.
///
/// Map соответствия между типами [Type] обрабатываемых ошибок
/// и стратегиями их обработок [ErrorHandlingStrategies].
/// Стратегия [standardErrorHandlingStrategy] является дефолтной
/// для ошибок модуля CI, [mapErrorStrategy] должна заполнятся дополнительными стратегиями
/// для модуля CI.
Map<Type, ErrorHandlingStrategies> get mapErrorStrategy => _mapErrorStrategy;
