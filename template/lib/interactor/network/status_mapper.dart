import 'package:dio/dio.dart';
import 'package:flutter_template/interactor/common/exceptions.dart';
import 'package:flutter_template/ui/base/standard_status_mapper.dart';

///Стандартный для проекта обработчик статус кода
class DefaultStatusMapper extends StandardStatusMapper {
  @override
  void checkClientStatus(Response response) {
    //todo смапить основные ошибки сервера в проекте
    try {
      switch (response.statusCode) {
        case 105:
          throw NotFoundException(response.statusMessage);
        default:
          super.checkClientStatus(response);
      }
    } on Exception {
      rethrow;
    }
  }
}
