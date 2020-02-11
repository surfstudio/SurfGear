import 'package:ci/exceptions/exceptions.dart';

abstract class ErrorHandler {
  void errorHandler(BaseCiException e);

  /// Неизвестная ошибка
  void unknownError(BaseCiException e);
}
