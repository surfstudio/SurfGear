import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/utils/exceptions.dart';

abstract class NetworkErrorHandler implements ErrorHandler {
  @override
  void handleError(Object e) {
    Exception exception;
    if (e is Exception) {
      exception = e;
    } else if (e is Error) {
      exception = Exception(e.stackTrace);
    } else {
      exception = Exception(e.toString());
    }

    if (exception is NoInternetException) {
      handleNoInternetException(exception);
    } else {
      handleOtherException(exception);
    }
  }

  void handleNoInternetException(NoInternetException exception);

  ///
  void handleOtherException(Exception exception);
}
