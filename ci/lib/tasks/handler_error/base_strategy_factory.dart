import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/handler_error/map_strategy.dart';

class BaseStrategyFactory {
  final Map<Type, errorStrategy> _mapException;

  final errorStrategy baseFun;

  /// Неизвестная ошибка
  final errorStrategy _unknownExceptionHandling;

  BaseStrategyFactory(this._mapException, this.baseFun, this._unknownExceptionHandling);

  errorStrategy handleError(BaseCiException error) {
    var type = error.runtimeType;

    if (_mapException.containsKey(type)) {
      return _mapException[type];
    }
    return baseFun;
  }

  errorStrategy unknownError(Exception error) {
    return _unknownExceptionHandling;
  }
}
