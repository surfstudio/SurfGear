import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/handler_error/ErrorHandler.dart';

abstract class TestErrorHandler extends ErrorHandler {
  final Map<Exception, String> map = {};

  TestErrorHandler() {
    //

  }

  @override
  void handleError(dynamic e) {
    if (e is BaseCiException) {
      handlerElementNotFoundException(e);
    } else {
      handleOtherError(e);
    }
  }

  void handlerElementNotFoundException(BaseCiException e);

  void handleOtherError(Exception e);
}
