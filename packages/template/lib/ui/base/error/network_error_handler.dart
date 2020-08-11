import 'package:surf_logger/surf_logger.dart';
import 'package:mwwm/mwwm.dart';
import 'package:network/surf_network.dart';

///Базовый класс для обработки ошибок, связанных с сервисным слоем
abstract class NetworkErrorHandler implements ErrorHandler {
  @override
  void handleError(Object e) {
    Exception exception;

    if (e is Error) {
      exception = Exception(e.stackTrace);
    } else if (e is Exception) {
      exception = e;
      Logger.d('NetworkErrorHandler handle error', exception);

      if (exception is ConversionException) {
        handleConversionError(exception);
      } else if (exception is NoInternetException) {
        handleNoInternetError(exception);
      } else if (exception is HttpProtocolException) {
        handleHttpProtocolException(exception);
      } else {
        handleOtherError(exception);
      }
    }
  }

  void handleConversionError(ConversionException e);

  void handleNoInternetError(NoInternetException e);

  void handleHttpProtocolException(HttpProtocolException e);

  void handleOtherError(Exception e);
}
