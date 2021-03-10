import 'package:dio/dio.dart';
import 'package:flutter_template/ui/base/error/http_exception.dart';

///Хелпер для проверки статус кода
// ignore: one_member_abstracts
abstract class StatusCodeMapper {
  dynamic checkStatus(Response response);
}

///Стандартный обработчик статус кода
class StandardStatusMapper extends StatusCodeMapper {
  @override
  dynamic checkStatus(Response response) {
    final statusCategory = _getFirstNumberFromStatus(response.statusCode);
    switch (statusCategory) {
      case 1:
        checkInformationalStatus(response);
        return;
      case 2:
        checkSuccessStatus(response);
        return;
      case 3:
        checkRedirectStatus(response);
        return;
      case 4:
        checkClientStatus(response);
        return;
      case 5:
        checkServerStatus(response);
        return;
      default:
        throw UnknownHttpStatusCode(response);
    }
  }

  ///status 1xx
  void checkInformationalStatus(Response response) {}

  ///status 2xx
  void checkSuccessStatus(Response response) {}

  ///status 3xx
  void checkRedirectStatus(Response response) {
    throw RedirectionHttpException(response);
  }

  ///status 4xx
  void checkClientStatus(Response response) {
    throw ClientHttpException(response);
  }

  ///status 5xx
  void checkServerStatus(Response response) {
    throw ServerHttpException(response);
  }

  ///получить первую цифру статус кода
  int _getFirstNumberFromStatus(int status) {
    final firstNumberStr = status.toString()[0];
    return int.parse(firstNumberStr);
  }
}
