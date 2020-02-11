import 'package:ci/exceptions/exceptions.dart';

abstract class ErrorHandler {
  void handler(BaseCiException e);
}
