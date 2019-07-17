import 'package:logger/logger.dart';
import 'package:mwwm/mwwm.dart';
import 'package:network/network.dart';

///Базовый класс для обработки ошибок, связанных с сервисным слоем
abstract class NetworkErrorHandler implements ErrorHandler {
  @override
  void handleError(Object e) {
    if (e is Error) {
      e = Exception((e as Error).stackTrace);
    }
    Logger.d("NetworkErrorHandler handle error", e);
    if (e is ConversionException) {
      handleConversionError(e);
    } else if (e is NoInternetException) {
      handleNoInternetError(e);
    } else if (e is HttpProtocolException) {
      handleHttpProtocolException(e);
    } else {
      handleOtherError(e);
    }
  }

  void handleConversionError(ConversionException e);

  void handleNoInternetError(NoInternetException e);

  void handleHttpProtocolException(HttpProtocolException e);

  void handleOtherError(Exception e);
}
