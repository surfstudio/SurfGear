import 'package:ci/exceptions/exceptions.dart';

abstract class ErrorHandler {
  Future<void> handler(BaseCiException e);
}
