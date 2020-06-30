import 'package:flutter_template/interactor/common/exceptions.dart';
import 'package:network/network.dart';

///Стандартный для проекта обработчик статус кода
class DefaultStatusMapper extends StandardStatusMapper {
  @override
  void checkClientStatus(Response response) {
    ErrorResponse er;

    //todo смаппить основные ошибки сервера в проекте
    try {
      er = ErrorResponse.fromJson(response.body);
      switch (er.errorCode) {
        case 105:
          throw NotFoundException(er.message);
        default:
          throw Exception('Another exception');
      }
    } catch (ex) {
      rethrow;
    }
  }
}

/// Респонс с ошибкой
class ErrorResponse {
  int errorCode;
  String message;

  ErrorResponse({this.errorCode, this.message});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['message'] = message;
    return data;
  }
}
