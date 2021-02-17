import 'package:flutter_template/interactor/common/exceptions.dart';
import 'package:flutter_template/util/extensions.dart';
import 'package:surf_network/surf_network.dart';

///Стандартный для проекта обработчик статус кода
class DefaultStatusMapper extends StandardStatusMapper {
  @override
  void checkClientStatus(Response response) {
    ErrorResponse er;

    //todo смапить основные ошибки сервера в проекте
    try {
      er = ErrorResponse.fromJson(response.body);
      switch (er.errorCode) {
        case 105:
          throw NotFoundException(er.message);
        default:
          super.checkClientStatus(response);
      }
    } on Exception {
      rethrow;
    }
  }
}

/// Response с ошибкой
class ErrorResponse {
  ErrorResponse({this.errorCode, this.message});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json.get<int>('errorCode');
    message = json.get<String>('message');
  }

  int errorCode;
  String message;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['message'] = message;
    return data;
  }
}
